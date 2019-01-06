Add-Type -AssemblyName PresentationFramework

[xml]$Form = @"
    <Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="My Firest Form" Height="480" Width="640">
    <Grid>
        <TabControl>
            <TabItem>
                <Grid>
                        <Canvas Background="LightBlue">
                            <Button Name="MyButton" Width="128" Height="45" Content='Hello' Opacity="0.5" ClickMode="Press" HorizontalAlignment="Left" Margin="65,201,0,0">
                            <Button.Effect>
                                <DropShadowEffect />
                            </Button.Effect>
                            </Button>
                            <Label Name="Label1" Content="Hello"/>
                            <TextBox Name="TextBox1" Height="30" Width="200" Margin="10,144,0,0" Text="Enter text"/>

        
                        </Canvas>

                </Grid>
            </TabItem>
        </TabControl>
    </Grid>
    
    

    </Window>
"@

#<Button Name="Button2" Width="120" Height="85" Content='Hello2' />

$NR = (New-Object System.Xml.XmlNodeReader $Form)

$Win = [Windows.Markup.XamlReader]::Load($NR)

$Win.Showdialog()
