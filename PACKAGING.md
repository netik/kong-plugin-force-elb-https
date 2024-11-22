From the kong manual:

# Packaging sources

You can either use a regular packing strategy (e.g. tar), or use the LuaRocks package manager to do it for you. We recommend LuaRocks as it is installed along with Kong when using one of the official distribution packages.

When using LuaRocks, you must create a rockspec file, which specifies the package contents. For an example, see the Kong plugin template. For more info about the format, see the LuaRocks documentation on rockspecs.

Pack your rock using the following command (from the plugin repo):

Install it locally (based on the .rockspec in the current directory):
```
 luarocks make
```

## Pack the installed rock:

Important: luarocks pack is dependent on the zip utility being installed. More recent images of Kong Gateway have been hardened, and utilities such as zip are no longer available. If this is being performed as part of a custom Docker image, ensure zip is installed prior to running this command.

```
 luarocks pack <plugin-name> <version>
```

Assuming your plugin rockspec is called kong-plugin-my-plugin-0.1.0-1.rockspec, the above would become;

```
 luarocks pack kong-plugin-my-plugin 0.1.0-1
```

The LuaRocks pack command has now created a .rock file (this is simply a zip file containing everything needed to install the rock).

If you do not or cannot use LuaRocks, then use tar to pack the .lua files of which your plugin consists into a .tar.gz archive. You can also include the .rockspec file if you do have LuaRocks on the target systems.

The contents of this archive should be close to the following:

```
tree <plugin-name>
<plugin-name>
├── INSTALL.txt
├── README.md
├── kong
│   └── plugins
│       └── <plugin-name>
│           ├── handler.lua
│           └── schema.lua
└── <plugin-name>-<version>.rockspec
```

# Install the plugin
For a Kong node to be able to use the custom plugin, the custom plugin’s Lua sources must be installed on your host’s file system. There are multiple ways of doing so: via LuaRocks, or manually. Choose one of the following paths.

Reminder: regardless of which method you are using to install your plugin’s sources, you must still do so for each node in your Kong cluster.

Via LuaRocks from the created ‘rock’
The .rock file is a self contained package that can be installed locally or from a remote server.

If the luarocks utility is installed in your system (this is likely the case if you used one of the official installation packages), you can install the ‘rock’ in your LuaRocks tree (a directory in which LuaRocks installs Lua modules).

It can be installed by doing:
```
luarocks install <rock-filename>
```
The filename can be a local name, or any of the supported methods, e.g. http://myrepository.lan/rocks/my-plugin-0.1.0-1.all.rock

