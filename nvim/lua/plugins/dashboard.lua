return {
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      opts = function(_, opts)
        local logo = [[
        
    ██████╗   ██████╗  ██████╗  ███╗   ██╗ ███████╗ ██╗   ██╗
    ██╔══██╗ ██╔═══██╗ ██╔══██╗ ████╗  ██║ ██╔════╝ ╚██╗ ██╔╝
    ██████╔╝ ██║   ██║ ██████╔╝ ██╔██╗ ██║ █████╗    ╚████╔╝ 
    ██╔══██╗ ██║   ██║ ██╔══██╗ ██║╚██╗██║ ██╔══╝     ╚██╔╝  
    ██████╔╝ ╚██████╔╝ ██║  ██║ ██║ ╚████║ ███████╗    ██║   
    ╚═════╝   ╚═════╝  ╚═╝  ╚═╝ ╚═╝  ╚═══╝ ╚══════╝    ╚═╝   
                                                            
        ]]
  
        logo = string.rep("\n", 8) .. logo .. "\n"
        opts.config.header = vim.split(logo, "\n")

        opts.config.footer = function()
          return { "⚡ The magic you are looking for is in the work you are avoiding ⚡" }
        end
      end,
    },
  }