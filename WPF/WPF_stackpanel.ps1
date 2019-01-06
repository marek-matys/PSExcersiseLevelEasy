Add-Type -AssemblyName PresentationFramework

[xml]$Form = @"
    <Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="My Firest Form" Height="480" Width="640">
    <StackPanel Name="StackPAnel1" Width="300" Height="200" Background="LightBlue" Orientation="Horizontal">
        <Button Name="MyButton" Width="120" Height="85" Content='Hello' />
        <Button Name="Button2" Width="120" Height="85" Content='Hello2' />
    </StackPanel>
    </Window>
"@

$NR = (New-Object System.Xml.XmlNodeReader $Form)

$Win = [Windows.Markup.XamlReader]::Load($NR)

$Win.Showdialog()
