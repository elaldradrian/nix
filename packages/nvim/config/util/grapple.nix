{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "grapple.nvim";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "cbochs";
        repo = "grapple.nvim";
        rev = "7aedc261b05a6c030397c4bc26416efbe746ebf1";
        hash = "sha256-apWKHEhXjFdS8xnSX0PoiOMzR+RVuYHFLV9sUl/HhTE=";
      };
    })
  ];

  extraConfigLua = # Lua
    ''
      vim.api.nvim_create_autocmd("VeryLazy", {
        callback = function()
          require('grapple').setup({
            scope = "git",
          })
        end,
      })
    '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action.__raw = # Lua
        ''
          function ()
            local grapple = require("grapple")

            -- Normalize to "/" and split
            local function split_path(p)
              p = p:gsub("\\", "/")
              local parts = {}
              for part in p:gmatch("[^/]+") do
                table.insert(parts, part)
              end
              return parts
            end

            local function tail(parts, depth)
              local n = #parts
              local d = math.min(depth, n)
              return table.concat(parts, "/", n - d + 1, n)
            end

            -- Compute minimal unique suffix for every tag (per-basename)
            local function compute_names(tags)
              local items = {}
              for i, tag in ipairs(tags) do
                local parts = split_path(tag.path)
                items[i] = { index = i, path = tag.path, parts = parts, base = parts[#parts] }
              end

              -- Group by basename
              local bybase = {}
              for _, it in ipairs(items) do
                local g = bybase[it.base]
                if not g then g = {}; bybase[it.base] = g end
                table.insert(g, { it = it, depth = 1 })
              end

              local names = {}

              for _, group in pairs(bybase) do
                if #group == 1 then
                  names[group[1].it.path] = group[1].it.base
                else
                  -- Increase depth only for the items that still collide
                  while true do
                    local seen = {}
                    local any_collision = false

                    for _, g in ipairs(group) do
                      local name = tail(g.it.parts, g.depth)
                      if seen[name] then
                        any_collision = true
                        g.collide = true
                        seen[name].collide = true
                      else
                        seen[name] = g
                        g.collide = false
                      end
                    end

                    if not any_collision then break end

                    for _, g in ipairs(group) do
                      if g.collide and g.depth < #g.it.parts then
                        g.depth = g.depth + 1
                      end
                    end
                  end

                  for _, g in ipairs(group) do
                    names[g.it.path] = tail(g.it.parts, g.depth)
                  end
                end
              end

              return names
            end

            -- 1) Toggle current file first so the tag list is up to date
            local filepath = vim.fn.expand("%:p")
            if grapple.exists({ path = filepath }) then
              grapple.untag({ path = filepath })
            else
              grapple.tag({ path = filepath })
            end

            -- 2) Fresh snapshot and compute names
            local tags = grapple.tags()
            local names = compute_names(tags)

            -- 3) Apply consistent "index. name" across all tags
            for i, tag in ipairs(tags) do
              local final = names[tag.path]
                            or (function()
                                  local parts = split_path(tag.path)
                                  return parts[#parts]
                                end)()
              grapple.tag({
                path = tag.path,
                name = i .. ". " .. final,
                index = i, -- keep stable order
              })
            end

            require('lualine').refresh({
              scope = 'tabpage',
              place = { 'statusline', 'winbar', 'tabline' },
            })
          end
        '';
      #  "<CMD>lua require('grapple').toggle({ name = vim.fn.expand('%:t') })<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>k";
      action = "<CMD> Grapple toggle_tags <CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>K";
      action = "<CMD> Grapple toggle_scopes <CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>1";
      action = "<CMD> Grapple select index=1<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>2";
      action = "<CMD> Grapple select index=2<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>3";
      action = "<CMD> Grapple select index=3<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>4";
      action = "<CMD> Grapple select index=4<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>5";
      action = "<CMD> Grapple select index=5<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>6";
      action = "<CMD> Grapple select index=6<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>7";
      action = "<CMD> Grapple select index=7<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>8";
      action = "<CMD> Grapple select index=8<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
    {
      mode = "n";
      key = "<leader>9";
      action = "<CMD> Grapple select index=9<CR>";
      options = {
        desc = "which_key_ignore"; # "Grapple Toggle tag";
      };
    }
  ];
}
