<#
    test.ps1
    
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

import-module pester;
import-module ../appdomainconfig;

describe "add-appsetting" {
    it "can set explicit setting by name" {
        $setting = add-appSetting -name 'TestSetting' -value 123                
        $null -ne $setting
    }
}

describe "get-appsetting" {
    it "can get explicit setting by name" {
        $name = 'get-appsetting-test-setting-1'
        add-appSetting -name $name -value 123 | out-null;                

        $null -ne (get-appSetting -name $name);
    }

    it "can get explicit setting by wilcard pattern" {
        $name = 'get-appsetting-test-setting-WC2'
        $pattern = 'get-appsetting-test-setting-WC*'
        add-appSetting -name $name -value 123 | out-null;                

        $null -ne (get-appSetting -name $pattern);
    }
}

describe "remove-appsetting" {
    it "can remove explicit setting by name" {
        $name = 'remove-appsetting-test-setting-1'
        add-appSetting -name $name -value 123 | out-null;                
        
        $existsbefore = $null -ne ( get-appSetting -name $name );
        remove-appSetting -name $name;
        $notexistsafter = $null -eq ( get-appSetting -name $name )

        $existsbefore -and $notexistsafter
    }

    it "can remove explicit setting by wilcard pattern" {
        $name = 'remove-appsetting-test-setting-WC1'
        $pattern = 'remove-appsetting-test-setting-W*'

        add-appSetting -name $name -value 123 | out-null;                
        
        $existsbefore = $null -ne (get-appSetting -name $name);
        remove-appSetting -name $pattern;
        $notexistsafter = $null -eq ( get-appSetting -name $name )

        $existsbefore -and $notexistsafter
    }
}

describe "add-connectionstring" {
    it "can set explicit connection by name" {
        $connection = add-connectionString -name 'testconnection' `
            -connectionString "Server=MyServer;Database=MyData;Trusted_Connection=True;Encrypt=True;Connection Timeout=30;" `
            -providerName System.Data.SqlClient

        $null -ne $connection
    }
}

describe "get-connectionstring" {
    it "can get explicit connection by name" {
        $name = 'get-connection-1'
        add-connectionString -name $name `
            -connectionString "Server=MyServer;Database=MyData;Trusted_Connection=True;Encrypt=True;Connection Timeout=30;" `
            -providerName System.Data.SqlClient | out-null

        $null -ne (get-connectionString -name $name);
    }

    it "can get explicit connection by wilcard pattern" {
        $name = 'get-connection-WC2'
        $pattern = 'get-connection-WC*'

        add-connectionString -name $name `
            -connectionString "Server=MyServer;Database=MyData;Trusted_Connection=True;Encrypt=True;Connection Timeout=30;" `
            -providerName System.Data.SqlClient | out-null

        $null -ne (get-connectionString -name $pattern);
    }
}

describe "remove-connectionstring" {
    it "can remove explicit connection by name" {
        $name = 'remove-connection-1'
        add-connectionString -name $name `
            -connectionString "Server=MyServer;Database=MyData;Trusted_Connection=True;Encrypt=True;Connection Timeout=30;" `
            -providerName System.Data.SqlClient | out-null

        
        $existsbefore = $null -ne ( get-connectionString -name $name );
        remove-connectionString -name $name;
        $notexistsafter = $null -eq ( get-connectionString -name $name )

        $existsbefore -and $notexistsafter
    }

    it "can remove explicit setting by wilcard pattern" {
        $name = 'remove-connection-WC2'
        $pattern = 'remove-connection-W*'
        add-connectionString -name $name `
            -connectionString "Server=MyServer;Database=MyData;Trusted_Connection=True;Encrypt=True;Connection Timeout=30;" `
            -providerName System.Data.SqlClient | out-null

        
        $existsbefore = $null -ne ( get-connectionString -name $name );
        remove-connectionString -name $name;
        $notexistsafter = $null -eq ( get-connectionString -name $name )

        $existsbefore -and $notexistsafter
    }
}




