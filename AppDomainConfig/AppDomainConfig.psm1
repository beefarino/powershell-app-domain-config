<#
    AppDomainConfig.psm1
    
    Copyright (c) 2014 Code Owls LLC, All Rights Reserved.
    http://www.codeowls.com

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>

[System.Management.Automation.WildcardOptions]$script:wcoptions = [System.Management.Automation.WildcardOptions]::Compiled -bor [System.Management.Automation.WildcardOptions]::IgnoreCase;

 
add-type -assembly system.configuration;

#-------------------------------------
# connection strings
$connectionStrings = [configuration.configurationManager]::connectionStrings;
$field = [configuration.configurationelementcollection].GetField( 
    "bReadOnly", 
    [System.Reflection.BindingFlags]::nonPublic -bor [System.Reflection.BindingFlags]::instance
);
$field.SetValue( $connectionStrings, $false );

function get-connectionString
{
    [cmdletbinding()]
    param(
        [parameter()]
        [string[]] $name
    );

    process
    {    
        if( -not $name )
        {
            $connectionStrings;
            return;
        }
                                  
        $pattern = New-Object System.Management.Automation.WildcardPattern $Name, $wcoptions
        
        $connectionStrings | where {$pattern.isMatch( $_.Name ) };
    }
<# 
   .SYNOPSIS 
   Retrieves one or more named connection strings from the current app domain configuration.
   .DESCRIPTION
   Retrieves one or more named connection strings from the current app domain configuration.
   .EXAMPLE 
   get-connectionString
   .NOTES
    NAME: get-connectionString
    AUTHOR: beefarino
    LASTEDIT: 11/07/2013 09:25:30 
    KEYWORDS: 
   .Link 
    http://www.codeowls.com
    https://github.com/beefarino/powershell-app-domain-config 
#> 
}

function remove-connectionString
{
    [cmdletbinding()]
    param(
        [parameter()]
        [string[]] $name                        
    );

    process
    {    
        if( -not $name )
        {            
            return;
        }
        
        get-connectionstring -name $name | foreach {
            
            $connectionStrings.remove( $_.Name )
        }
    }

<# 
   .SYNOPSIS 
   Removes a named connection string from the current app domain configuration
   .DESCRIPTION
   Removes a named connection string from the current app domain configuration
   .EXAMPLE 
   remove-connectionString -name "MyConnectionString" 
   .NOTES
    NAME: remove-connectionString
    AUTHOR: beefarino
    LASTEDIT: 11/07/2013 09:21:12 
    KEYWORDS: 
   .Link 
    http://www.codeowls.com
    https://github.com/beefarino/powershell-app-domain-config 
#> 
}

function add-connectionString
{
    [cmdletbinding()]
    param(
        [parameter(mandatory=$true)]
        [string] $name
        
        ,[parameter(mandatory=$true)]
        [string] $connectionString
        
        ,[parameter()]
        [string] $providerName
    );

    process
    {    
        remove-connectionString -name $name;
        
        $c = new-object system.configuration.connectionstringsettings -arg $name,$connectionString,$providerName
        $connectionStrings.add( $c );
        get-connectionString -name $name;
    }
<# 
   .SYNOPSIS 
    Adds or replaces a new named connection string to the current app domain configuration
   .DESCRIPTION
   Adds or replaces a new named connection string to the current app domain configuration
   .EXAMPLE 
   add-connectionString -name "MyConnectionString" -connectionString "Server=MyServer;Database=MyData;Trusted_Connection=True;Encrypt=True;Connection Timeout=30;" -providerName System.Data.SqlClient
   .NOTES
    NAME: add-connectionString
    AUTHOR: beefarino
    LASTEDIT: 11/07/2013 09:21:12 
    KEYWORDS: 
   .Link 
    http://www.codeowls.com
    https://github.com/beefarino/powershell-app-domain-config 
#> 
}

#-------------------------------------
# application settings
$applicationSettings = [configuration.configurationManager]::appSettings;

$field = [system.collections.specialized.nameobjectcollectionbase].GetField( 
    "_readOnly", 
    [System.Reflection.BindingFlags]([System.Reflection.BindingFlags]::nonPublic -bor [System.Reflection.BindingFlags]::instance)
);

$field.SetValue( $applicationSettings, $false );

$collType = [system.configuration.configurationmanager].assembly.getType('System.Configuration.KeyValueInternalCollection');
$field = $collType.GetField( 
    "_root",
    [System.Reflection.BindingFlags]([System.Reflection.BindingFlags]::nonPublic -bor [System.Reflection.BindingFlags]::instance)
);
$appSettingsValue = $field.GetValue( $applicationSettings );
$field = [configuration.configurationelement].GetField( 
    "_bReadOnly", 
    [System.Reflection.BindingFlags]::nonPublic -bor [System.Reflection.BindingFlags]::instance
);
$field.SetValue( $appSettingsValue, $false );

$field = [configuration.AppSettingsSection].GetProperty( 
    "Settings", 
    [System.Reflection.BindingFlags]([System.Reflection.BindingFlags]::public -bor [System.Reflection.BindingFlags]::instance)
);
$appSettingsSettings = $field.GetValue( $appSettingsValue );

$field = [configuration.configurationelementcollection].GetField( 
    "bReadOnly", 
    [System.Reflection.BindingFlags]::nonPublic -bor [System.Reflection.BindingFlags]::instance
);
$field.SetValue( $appSettingsSettings, $false );

function get-appSetting
{
    [cmdletbinding()]
    param(
        [parameter()]
        [string[]] $name
    );

    process
    {    
        if( -not $name )
        {
            $appSettingsSettings;
            return;
        }
                                  
        $pattern = New-Object System.Management.Automation.WildcardPattern $Name, $wcoptions
        
        $appSettingsSettings | where {$pattern.isMatch( $_.Key ) };
    }
<# 
   .SYNOPSIS 
   Retrieves one or more named application settings from the current app domain configuration.
   .DESCRIPTION
   Retrieves one or more named application settings from the current app domain configuration.
   .EXAMPLE 
   get-appSetting
   .NOTES
    NAME: get-appSetting
    AUTHOR: beefarino
    LASTEDIT: 01/13/2014 09:23:22 PM
    KEYWORDS: 
   .Link 
    http://www.codeowls.com
    https://github.com/beefarino/powershell-app-domain-config 
#> 
}

function remove-appSetting
{
    [cmdletbinding()]
    param(
        [parameter()]
        [string[]] $name                        
    );

    process
    {    
        if( -not $name )
        {            
            return;
        }
        
        get-appSetting -name $name | foreach {
            write-debug "Removing application setting $($_.key)"
            $appSettingsSettings.remove( $_.key )
        }
    }

<# 
   .SYNOPSIS 
   Removes a named application setting from the current app domain configuration
   .DESCRIPTION
   Removes a named application setting from the current app domain configuration
   .EXAMPLE 
   remove-appSetting -name "MySetting" 
   .NOTES
    NAME: remove-connectionString
    AUTHOR: beefarino
    LASTEDIT: 01/13/2014 09:26:10 PM
    KEYWORDS: 
   .Link 
    http://www.codeowls.com
    https://github.com/beefarino/powershell-app-domain-config 
#> 
}

function add-appSetting
{
    [cmdletbinding()]
    param(
        [parameter(mandatory=$true)]
        [string] $name
        
        ,[parameter(mandatory=$true)]
        [string] $value
    );

    process
    {    
        remove-appSetting -name $name;
        $appSettingsSettings.add( $name, $value );
        get-appSetting -name $name;
    }
<# 
   .SYNOPSIS 
    Adds or replaces a new named application setting to the current app domain configuration
   .DESCRIPTION
   Adds or replaces a new named application setting to the current app domain configuration
   .EXAMPLE 
   add-appSetting -name "MySetting" -value "This is my setting value"
   .NOTES
    NAME: add-appSetting
    AUTHOR: beefarino
    LASTEDIT: 01/13/2014 09:27:12 PM 
    KEYWORDS: 
   .Link 
    http://www.codeowls.com
    https://github.com/beefarino/powershell-app-domain-config 
#> 

}

remove-item variable:/field;
remove-item variable:/colltype;