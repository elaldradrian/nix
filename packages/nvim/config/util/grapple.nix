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
      require('grapple').setup({
        scope = "git",
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

            function getExisting(tbl, value)
              for _, obj in ipairs(tbl) do
                if string.sub(obj.name, 4, string.len(obj.name)) == value then
                  return obj
                end
              end
              return nil
            end

            local function setNames(target_filename, partCount)
              local tags = grapple.tags()
              local matching_tags = {}

              for i, tag in ipairs(tags) do
                if tag.path:match(target_filename:gsub("%-", "%%-") .. "$") then
                  tag.index = i
                  table.insert(matching_tags, tag)
                elseif partCount == 1 then
                  grapple.tag({ path = tag.path, name = i..". "..string.sub(tag.name, 4, string.len(tag.name)), index = i })
                end
              end

              for i = #matching_tags, 1, -1 do
                local tag = matching_tags[i]
                local parts = vim.split(tag.path, "/", { trimempty = true })

                local new_name = table.concat(parts, "/", #parts - partCount + 1, #parts)

                local existing = getExisting(matching_tags,new_name)
                if existing ~= nil then
                  if existing.path ~= tag.path then
                    setNames(target_filename, partCount + 1)
                  end
                else
                  grapple.tag({ path = tag.path, name = tag.index..". "..new_name, index = i , index = tag.index })
                end
              end
            end

            local filepath = vim.fn.expand("%:p")
            if grapple.exists({ path = filepath }) then
              grapple.untag({ path = filepath })
            else
              grapple.tag({ path = filepath, name = "N. tmp" })
            end
            setNames(vim.fn.expand('%:t'), 1)
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
