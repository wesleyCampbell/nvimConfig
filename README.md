# NVIM Config Files

---

## Overview

This repository contains my configuration files for the [Neovim](https://github.com/neovim/neovim) text editor. 

This configuration includes plugins, custom keybinds, LSP configs, among other personal tweaks and changes I have included as time progressed. I have divided the lua directory into several sub-directories/categories:
- plugins (holds plugin configurations, surprisingly)
- lsp_client_configs (holds configs for LSP integration on a per-language basis)
- custom_configs (holds miscellaneous configs such as keybinds)
- lib (holds utility functions for use in other locations)

## Plugins

### Adding or Removing a Plugin

To add a new plugin one can add a new .lua file in the `lua/plugins` directory. To remove a plugin, simply remove the file from the directory or rename it to `{plugin-name}.lua.old`. The `{plugin-name}.lua` file must return a table that holds another table containing the plugin configuration. An example of this is as follows:
```lua
-- myPlugin.lua

local myPluginConf = {
   -- The GitHub path of the plugin
   'githubUser/myPluginConf', 
   dependencies = {
        'githubUser/dep1',
        'githubUser/dep2',
        ...
    }
    ...
}

return {
    myPluginConf,
}
```

Each plugin will recommend a specific configuration. Include it in the `{plugin-name}.lua` file exactly as the plugin recommends. 

Note that it is also possible to define the plugin configuration table within the return table as follows:
```lua
-- myPlugin.lua
return {
    {
        'githubUser/myPluginConf',
        dependencies = {
            'githubUser/dep1',
        }
    },
}
```

This format is not recommended as it can impair readiblity and understanding, especially when multiple plugin configurations are returned at once.

### Adding Multiple Plugins in One File

It is possible to include several plugins in one lua file. This can be of use when certain plugins depend on each other or you wish to group them into one function-group. To include several different plugins, follow this syntax:
```lua
-- myPlugin.lua
-- Up top you will define all of your plugin configurations
local myPluginConf1 = {
    ...  -- Plugin configuration goes here
}

local myPluginConf2 = {
    ...  -- Plugin configuration goes here
}

local myPluginConf3 = {
    ...  -- Plugin configuration goes here
}

return {
    myPluginConf1,
    myPluginConf2,
    myPluginConf3,
}
```

After you have configured your plugin to your liking, `lua/plugins/init.lua` will automatically load the plugins into your configuration. No additional step is required.

### Post-Loading Plugin Configuration

Some plugins have additional configuration options that can only be accessed after being loaded. If this is the case, include a function within the return table as so:
```lua
-- myPlugin.lua

-- myPluginConf defined above...

function postLoadConfig()
    print("This is some additional config!")
end

return {
    myPluginConf,
    configFunc = postLoadConfig,
}
```
Unlike the plugin configuration tables, the post-load configuration function needs to be associated with the key `configFunc`. Following lua syntax, it is also possible to define `configFunc` within the return table as follows:
```lua
-- myPlugin.lua

-- myPluginConf defined above...
return {
    myPluginConf,
    configFunc = function()
        print("This is the same additional config!")
    end
}
```
This can work for very simple configurations, but often it is better to define a function above then reference it in the return table. This will be required when you wish to include multiple plugins that require post-load configuration in the same file as the return table can only have one `configFunc` value at a time. 
    
## LSP Server Plugins

Unlike plugins, LSPs will not be automatically installed onto your system. If you desire to use a specific LSP, you must install it onto your machine and ensure that it can be located on the system's PATH. 

The LSP server configuration is very similar to plugin configuration. To add a LSP server to your Neovim configuration, create a new lua file inside `lua/lsp_server_configs`. To remove it, simply remove the file from the directory or change its file extension. 

Unlike plugins, it is not possible to include more than one LSP per file. The syntax for the `{lsp_name}.lua` file is as follows:
```lua
local lsp_server_config = {
    -- Whatever config you want goes here
}

return {
    name = "{lsp-name}",
    config = lsp_server_config,
}
```

The return table must contain a `name` entry that holds the LSP's name (as found on the system PATH) and a `config` entry that contains the LSP configuration.

Upon saving the file, `lua/lsp_server_configs/init.lua` will automatically search for the LSP on your system PATH and load it into Neovim, ready to be used with your specific configurations.

## Custom Configurations

Any miscellaneous configurations are stored in `lua/custom_configs`. These currently include custom keybinds, scripts that allow for better terminal management, and some miscellaneous visual tweaks. 

This module is the simplest of them all, and including new functionality is as simple as creating a new lua file and writing the script. There is no need to return anything from new lua file, as `lua/custom_configs/init.lua` only runs the file, loading variables, functions, and running commands. 

Currently, there is no way of managing dependencies between files, so it is best to keep each file self-contained. As of date, removing any one file within `/lua/custom_configs` will have no affect on any other functionality (except for `init.lua`, which is the backbone of the system, of course). 

## Lib

I maintain this directory for custom functions that other files depend on but do not directly affect the user experience. This directory stores functionality that needs to be universally accessed. 

Currently, the `lua/lib` directory contains files that allow for better manipulation of the file-system and of lua tables. 

When writing a function that could be universally useful ways or including a lua script from an external source, this is a good place to put it. 
