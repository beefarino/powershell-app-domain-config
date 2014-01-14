# powershell-app-domain-config

Allows you to modify the appsettings and connection strings in the active app domain configuration of your PowerShell session.  This allows you to leverage other .NET components that rely on app settings and/or connection string configurations from PowerShell without resorting to editing or reproducing the PowerShell application configuration file.

## Quick Start

    > import-module appdomainconfig
    > add-appsetting -name 'mysetting' -value 12345


    Key                     : mysetting
    Value                   : 12345
    LockAttributes          : {}
    LockAllAttributesExcept : {}
    LockElements            : {}
    LockAllElementsExcept   : {}
    LockItem                : False
    ElementInformation      : System.Configuration.ElementInformation
    CurrentConfiguration    :



    > add-connectionstring -name 'myconnection' -connectionString "Server=MyServer;Database=My
    Data" -providerName System.Data.SqlClient


    Name                    : myconnection
    ConnectionString        : Server=MyServer;Database=MyData
    ProviderName            : System.Data.SqlClient
    LockAttributes          : {}
    LockAllAttributesExcept : {}
    LockElements            : {}
    LockAllElementsExcept   : {}
    LockItem                : False
    ElementInformation      : System.Configuration.ElementInformation
    CurrentConfiguration    :



    > get-appsetting


    Key                     : mysetting
    Value                   : 12345
    LockAttributes          : {}
    LockAllAttributesExcept : {}
    LockElements            : {}
    LockAllElementsExcept   : {}
    LockItem                : False
    ElementInformation      : System.Configuration.ElementInformation
    CurrentConfiguration    :



    > get-connectionstring


    Name                    : LocalSqlServer
    ConnectionString        : data source=.\SQLEXPRESS;Integrated Security=SSPI;AttachDBFilen
                              ame=|DataDirectory|aspnetdb.mdf;User Instance=true
    ProviderName            : System.Data.SqlClient
    LockAttributes          : {}
    LockAllAttributesExcept : {}
    LockElements            : {}
    LockAllElementsExcept   : {}
    LockItem                : False
    ElementInformation      : System.Configuration.ElementInformation
    CurrentConfiguration    :

    Name                    : myconnection
    ConnectionString        : Server=MyServer;Database=MyData
    ProviderName            : System.Data.SqlClient
    LockAttributes          : {}
    LockAllAttributesExcept : {}
    LockElements            : {}
    LockAllElementsExcept   : {}
    LockItem                : False
    ElementInformation      : System.Configuration.ElementInformation
    CurrentConfiguration    :



    > remove-appsetting -name *
    > remove-connectionstring -name *
    > get-appsetting
    # no results
    > get-connectionstring
    # no results

## Exported Functions

### add-appSetting
    
    SYNOPSIS
        Adds or replaces a new named application setting to the current app domain 
        configuration
    
    
    SYNTAX
        add-appSetting [-name] <String> [-value] <String> [<CommonParameters>]
    
    
    DESCRIPTION
        Adds or replaces a new named application setting to the current app domain 
        configuration
    
### add-connectionString
    
    SYNOPSIS
        Adds or replaces a new named connection string to the current app domain 
        configuration
    
    
    SYNTAX
        add-connectionString [-name] <String> [-connectionString] <String> [[-providerName] 
        <String>] [<CommonParameters>]
    
    
    DESCRIPTION
        Adds or replaces a new named connection string to the current app domain 

### get-appSetting
    
    SYNOPSIS
        Retrieves one or more named application settings from the current app domain 
        configuration.
    
    
    SYNTAX
        get-appSetting [[-name] <String[]>] [<CommonParameters>]
    
    
    DESCRIPTION
        Retrieves one or more named application settings from the current app domain 
        configuration.
    
### get-connectionString
    
    SYNOPSIS
        Retrieves one or more named connection strings from the current app domain 
        configuration.
    
    
    SYNTAX
        get-connectionString [[-name] <String[]>] [<CommonParameters>]
    
    
    DESCRIPTION
        Retrieves one or more named connection strings from the current app domain 
        configuration.
    
### remove-appSetting
    
    SYNOPSIS
        Removes a named application setting from the current app domain configuration
    
    
    SYNTAX
        remove-appSetting [[-name] <String[]>] [<CommonParameters>]
    
    
    DESCRIPTION
        Removes a named application setting from the current app domain configuration

### remove-connectionString
    
    SYNOPSIS
        Removes a named connection string from the current app domain configuration
    
    
    SYNTAX
        remove-connectionString [[-name] <String[]>] [<CommonParameters>]
    
    
    DESCRIPTION
        Removes a named connection string from the current app domain configuration
    
