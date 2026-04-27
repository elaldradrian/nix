{
  pkgs,
  lib,
  config,
  gpuBackend,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  useSycl = gpuBackend == "intel" || gpuBackend == "both";
  useCuda = gpuBackend == "nvidia" || gpuBackend == "both";

  oneTBB = pkgs.tbb_2022;
  oneTBB-merged = pkgs.runCommand "onetbb-${oneTBB.version}-merged" { } ''
    mkdir -p $out
    cp -rL ${oneTBB}/. $out/
    chmod -R u+w $out
    cp -rLn ${oneTBB.dev}/. $out/ || true
    chmod -R u+w $out

    cat >> $out/lib/cmake/TBB/TBBConfig.cmake <<'EOF'
    set(TBB_tbb_FOUND TRUE)
    set(TBB_tbbmalloc_FOUND TRUE)
    set(TBB_tbbmalloc_proxy_FOUND TRUE)
    set(TBB_tbbbind_2_5_FOUND TRUE)
    EOF
  '';

  onednnSrc = pkgs.fetchurl {
    url = "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/784671be-a9aa-4264-b1f8-3dd44d5f972d/intel-onednn-2025.3.0.410_offline.sh";
    hash = "sha256-vhHjje3slg7yt8eWz32J6EEQtf/M90zSyzgk2j2xmtE=";
  };

  dpcpp = pkgs.stdenv.mkDerivation {
    pname = "dpcpp";
    version = "6.3.0";

    src = pkgs.fetchurl {
      url = "https://github.com/intel/llvm/releases/download/v6.3.0/sycl_linux.tar.gz";
      hash = "sha256-GwbYndDmTKpXi78q5y8DtxeLxgzZFFFLdzNyW/ByHZc=";
    };

    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.autoAddDriverRunpath
    ];

    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      pkgs.ncurses
      pkgs.zstd
      pkgs.libxml2.out
      pkgs.level-zero
      pkgs.ocl-icd
    ];

    autoPatchelfIgnoreMissingDeps = [
      "libxml2.so.2"
      "libcuda.so.1"
      "libcupti.so.12"
      "libnvidia-ml.so.1"
      "libamdhip64.so.6"
    ];

    sourceRoot = ".";
    dontBuild = true;
    dontStrip = true;

    installPhase = ''
      mkdir -p $out
      cp -a bin lib include share $out/ 2>/dev/null || true
    '';

    passthru.isClang = true;
  };

  dpcpp-wrapped = pkgs.wrapCCWith {
    cc = dpcpp;
    bintools = pkgs.stdenv.cc.bintools;
    extraBuildCommands = ''
      mv $out/bin/clang++ $out/bin/clang++-real
      cat > $out/bin/clang++ <<EOF
      #!${pkgs.bash}/bin/bash
      exec "$out/bin/clang++-real" -fsycl "\$@"
      EOF
      chmod +x $out/bin/clang++
    '';
  };

  intel-compiler-rt = pkgs.stdenv.mkDerivation {
    pname = "intel-compiler-rt";
    version = "2025.3.0";

    src = onednnSrc;

    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.p7zip
    ];

    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      oneTBB
    ];

    dontUnpack = true;

    buildPhase = ''
      runHook preBuild
      set -x

      sh $src -x -f ./extracted -s

      CUP=$(find ./extracted -name "cupPayload.cup" -path "*compilers-common.runtime*" | head -1)
      echo "payload: $CUP"

      mkdir -p ./payload
      7z x "$CUP" -o./payload

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib
      cp -a ./payload/_installdir/compiler/*/lib/* $out/lib/ 2>/dev/null || \
        find ./payload -name "libsvml*" -o -name "libimf*" -o -name "libintlc*" -o -name "libirng*" \
          -exec cp -a {} $out/lib/ \;
      runHook postInstall
    '';

    dontStrip = true;
  };

  onednn = pkgs.stdenv.mkDerivation {
    pname = "intel-onednn";
    version = "2025.3.0";

    src = onednnSrc;

    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.p7zip
    ];

    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      oneTBB
      pkgs.ocl-icd
      dpcpp
      intel-compiler-rt
    ];

    dontUnpack = true;

    buildPhase = ''
      runHook preBuild
      set -x

      sh $src -x -f ./extracted -s

      CUP=$(find ./extracted -name "cupPayload.cup" -path "*dnnl*" | head -1)
      echo "payload: $CUP"

      7z x "$CUP" -o./payload

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -a ./payload/_installdir/dnnl/2025.3/* $out/
      runHook postInstall
    '';

    dontStrip = true;
  };

  onemkl = pkgs.stdenv.mkDerivation {
    pname = "intel-onemkl";
    version = "2025.3.1";

    src = pkgs.fetchurl {
      url = "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6a17080f-f0de-41b9-b587-52f92512c59a/intel-onemkl-2025.3.1.11_offline.sh";
      hash = "sha256-iXU84L6C0xZpFywIxra4Y/LiVVjXdUljSUc7MpkkCgE=";
    };

    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.p7zip
    ];

    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      oneTBB
      pkgs.ocl-icd
      dpcpp
      intel-compiler-rt
    ];

    autoPatchelfIgnoreMissingDeps = [
      "libiomp5.so"
      "libmpi.so.12"
      "libmpicxx.so.12"
      "libmpifort.so.12"
    ];

    dontUnpack = true;

    buildPhase = ''
      runHook preBuild
      set -x

      sh $src -x -f ./extracted -s

      DEVEL=$(find ./extracted -name "cupPayload.cup" -path "*mkl.devel*" | head -1)
      RUNTIME=$(find ./extracted -name "cupPayload.cup" -path "*mkl.runtime*" | head -1)
      echo "devel:   $DEVEL"
      echo "runtime: $RUNTIME"

      mkdir -p ./payload-devel ./payload-runtime
      7z x "$DEVEL"   -o./payload-devel
      7z x "$RUNTIME" -o./payload-runtime

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -a ./payload-runtime/_installdir/mkl/2025.3/. $out/
      cp -a ./payload-devel/_installdir/mkl/2025.3/.   $out/

      rm -rf $out/share/mkl/benchmarks

      runHook postInstall
    '';

    dontStrip = true;
  };

  llama-pkgs =
    (pkgs.llama-cpp.override {
      rpcSupport = false;
      cudaSupport = useCuda;
      cudaPackages = pkgs.cudaPackages_13_1;
    }).overrideAttrs
      (prev: {
        version = "8929";
        src = prev.src.override {
          tag = "b8929";
          hash = "sha256-4p+iQRgLua5zVt171wr7yNGu3iEnEMa/sJXr5wQZNrM=";
        };
        npmDeps = pkgs.fetchNpmDeps {
          name = "llama-cpp-8884-npm-deps";
          inherit (prev) patches;
          src = prev.src.override {
            tag = "b8929";
            hash = "sha256-4p+iQRgLua5zVt171wr7yNGu3iEnEMa/sJXr5wQZNrM=";
          };
          preBuild = "pushd tools/server/webui";
          hash = "sha256-RAFtsbBGBjteCt5yXhrmHL39rIDJMCFBETgzId2eRRk=";
        };

        hardeningDisable =
          (prev.hardeningDisable or [ ])
          ++ lib.optionals useSycl [
            "zerocallusedregs"
            "fortify"
            "fortify3"
          ];

        nativeBuildInputs =
          (prev.nativeBuildInputs or [ ])
          ++ [ pkgs.makeBinaryWrapper ]
          ++ lib.optionals useSycl [ pkgs.autoAddDriverRunpath ];

        buildInputs =
          (prev.buildInputs or [ ])
          ++ [ pkgs.llvmPackages.openmp ]
          ++ lib.optionals useSycl [
            onemkl
            onednn
            dpcpp
            intel-compiler-rt
            pkgs.level-zero
            pkgs.ocl-icd
            oneTBB-merged
          ];

        cmakeFlags =
          (prev.cmakeFlags or [ ])
          ++ [ "-DGGML_OPENMP=ON" ]
          ++ lib.optionals useSycl [
            "-DGGML_SYCL=ON"
            "-DGGML_SYCL_TARGET=INTEL"
            "-DGGML_SYCL_DNN=ON"
            "-DCMAKE_C_COMPILER=${dpcpp-wrapped}/bin/clang"
            "-DCMAKE_CXX_COMPILER=${dpcpp-wrapped}/bin/clang++"
            "-DDNNL_DIR=${onednn}/lib/cmake/dnnl"
            "-DMKL_DIR=${onemkl}/lib/cmake/mkl"

            "-DMKL_THREADING=tbb_thread"
            "-DMKL_SYCL_THREADING=tbb_thread"

            "-DTBB_DIR=${oneTBB-merged}/lib/cmake/TBB"

            "-DGGML_NATIVE=OFF"
            "-DGGML_AVX=ON"
            "-DGGML_AVX2=ON"
            "-DGGML_FMA=ON"
            "-DGGML_F16C=ON"
            "-DGGML_BMI2=ON"
            "-DGGML_AVX512=ON"
            "-DGGML_AVX512_VBMI=ON"
            "-DGGML_AVX512_VNNI=ON"
            "-DGGML_AVX512_BF16=ON"

            "-DOpenMP_C_FLAGS=-fopenmp=libomp"
            "-DOpenMP_CXX_FLAGS=-fopenmp=libomp"
            "-DOpenMP_C_LIB_NAMES=omp"
            "-DOpenMP_CXX_LIB_NAMES=omp"
            "-DOpenMP_omp_LIBRARY=${pkgs.llvmPackages.openmp}/lib/libomp.so"
          ];

        postInstall = lib.optionalString (!useSycl) (prev.postInstall or "");

        postFixup =
          (prev.postFixup or "")
          + lib.optionalString useSycl ''
            for bin in $out/bin/llama-*; do
              [ -x "$bin" ] || continue
              wrapProgram "$bin" \
                --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib
            done
          '';
      });

  llama-server = "${llama-pkgs}/bin/llama-server";

  darwinModelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { } {
      "" = {
        version = "1";
      };
      "qwen3.6-35b-a3b" = {
        model = "/Users/rdb/models/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        parallel = "1";
        keep = "-1";
        temp = "0.6";
        top-p = "0.95";
        top-k = "20";
        min-p = "0.00";
        presence-penalty = "0";
        repeat-penalty = "1";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
      };
      "qwen3.5-27b" = {
        model = "/Users/rdb/models/Qwen3.5-27B-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        parallel = "1";
        keep = "-1";
        temp = "0.6";
        top-p = "0.95";
        top-k = "20";
        min-p = "0.00";
        presence-penalty = "0";
        repeat-penalty = "1";
      };
      "gemma-4-26b-a4b" = {
        model = "/Users/rdb/models/gemma-4-26B-A4B-it-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        parallel = "1";
        keep = "-1";
        temp = "1";
        top-p = "0.95";
        top-k = "64";
        repeat-penalty = "1";
      };
      "gemma-4-31b" = {
        model = "/Users/rdb/models/gemma-4-31B-it-UD-Q4_K_XL.gguf";
        jinja = "true";
        c = "65536";
        ctx-checkpoints = "1";
        parallel = "1";
        keep = "-1";
        temp = "1";
        top-p = "0.95";
        top-k = "64";
        repeat-penalty = "1";
      };
    }
  );

  linuxModelsIni = pkgs.writeText "models.ini" (
    lib.generators.toINI { listsAsDuplicateKeys = true; } {
      "qwen3.6-27b" = {
        model = "/home/rune/models/Qwen3.6-27B-Q4_K_M.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "1";
        ctx-size = "5000";
        fit-target = "1024";
        fit = "on";
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "2048";
      };
      "qwen3.6-35b-a3b" = {
        model = "/home/rune/models/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
        jinja = "true";
        chat-template-kwargs = ''{"preserve_thinking": true}'';
        no-warmup = "true";
        ctx-checkpoints = "64";
        checkpoint-every-n-tokens = "2048";
        cache-ram = "24576";
        ctx-size = "131072";
        fit-target = "256";
        fit = "on";
        keep = "-1";
        min-p = "0.00";
        no-mmap = "true";
        parallel = "1";
        presence-penalty = "0";
        repeat-penalty = "1";
        temp = "0.6";
        top-k = "20";
        top-p = "0.95";
        batch-size = "2048";
        ubatch-size = "2048";
        device = "Cuda0";
      };
    }
  );

in
{
  config = lib.mkIf (config.opt.features.llama-cpp.enable) {
    home.packages = [ llama-pkgs ];
    # Linux
    systemd.user.services.llama-cpp = lib.mkIf isLinux {
      Unit = {
        Description = "llama.cpp server (models.ini)";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${llama-server} --host 0.0.0.0 --port 11434 --models-preset ${linuxModelsIni} --models-max 1";
        Restart = "on-failure";
        LimitMEMLOCK = "infinity";
      };
      Install.WantedBy = [ "default.target" ];
    };

    # macOS
    launchd.agents.llama-cpp = lib.mkIf isDarwin {
      enable = true;
      config = {
        ProgramArguments = [
          "${llama-server}"
          "--host"
          "0.0.0.0"
          "--port"
          "11434"
          "--models-preset"
          "${darwinModelsIni}"
        ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/llama-cpp.log";
        StandardErrorPath = "/tmp/llama-cpp.err.log";
      };
    };
  };
}
