# Define a class
class RSSFeedCreator
{
   # Property with validate set
   #[ValidateSet("val1", "Val2")]
   [string] $P1

   # Static property
   static [hashtable] $P2

   # Hidden property does not show as result of Get-Member
   hidden [int] $P3

   $site = ""

   # Constructor
   RSSFeedCreator([string] $s)
   {
       $this.P1 = $s
       $this.site = Invoke-WebRequest $this.P1
   }



   # Static method
   static [void] MemberMethod1([hashtable] $h)
   {
       [RSSFeedCreator]::P2 = $h
   }

   # Instance method
   [int] MemberMethod2([int] $i)
   {
       $this.P3 = $i
       return $this.P3
   }

}

$Error.Clear()


$HTMLSite =  [RSSFeedCreator]::new("http://www.mf.gov.pl/krajowa-administracja-skarbowa/dzialalnosc/jednolity-plik-kontrolny/komunikaty")

$HTMLLinks = $HTMLSite.site.Links | where {$_.outerHTML -like "*asset_publisher*" -and $_.outerText -notlike "*Czytaj więcej*"}


$xml = [xml]::new()

$declaration = $xml.CreateXmlDeclaration("1.0","UTF-8",$null)

$xml.AppendChild($declaration)

$rss = $xml.CreateElement("rss")

$rss.SetAttribute("version","2.0")
$rss.SetAttribute("xmlns:atom","http://www.w3.org/2005/Atom")

$xml.AppendChild($rss)

$channel = $xml.CreateElement("channel")

$rss.AppendChild($channel)

$title = $xml.CreateElement("title")
$title_text = $xml.CreateTextNode("RSS Title")
$title.AppendChild($title_text)


$channel.AppendChild($title)


$link = $xml.CreateElement("link")
$link.AppendChild($xml.CreateTextNode("https://www.w3schools.com"))

$channel.AppendChild($link)


$lastBuildDate = $xml.CreateElement("lastBuildDate")
$lastBuildDate.AppendChild($xml.CreateTextNode("Mon, 06 Sep 2010 00:01:00 +0000"))

$channel.AppendChild($lastBuildDate)

$pubDate = $xml.CreateElement("pubDate")
$pubDate.AppendChild($xml.CreateTextNode("Sun, 06 Sep 2009 16:20:00 +0000"))


$channel.AppendChild($pubDate)


$ttl= $xml.CreateElement("ttl")
$ttl.AppendChild($xml.CreateTextNode("1800"))

$channel.AppendChild($ttl)


$description = $xml.CreateElement("description")
$description.AppendChild($xml.CreateTextNode("Free web building tutorials"))

$channel.AppendChild($description)


$atom = $xml.CreateElement("atom","link","http://www.w3.org/2005/Atom")

$atom.SetAttribute("href","http://dallas.example.com/rss.xml")
$atom.SetAttribute("rel","self")
$atom.SetAttribute("type","application/rss+xml")

$channel.AppendChild($atom)

#tu foreach

foreach($HTMLLink in $HTMLLinks){

    $item = $xml.CreateElement("item")

    $title = $HTMLLink.innerHTML
    
    $title = $title -replace '<[^>]+>',''
    $title_node = $xml.CreateElement("title")
    $title_node.AppendChild($xml.CreateTextNode($title))    
    
    $item.AppendChild($title_node)

    $link = $HTMLLink.href

    $link_node = $xml.CreateElement("link")
    $link_node.AppendChild($xml.CreateTextNode($link))
    $item.AppendChild($link_node)

    $description = $HTMLLink.innerHTML

    $description_node = $xml.CreateElement("description")
    $description_node.AppendChild($xml.CreateTextNode($description))
    $item.AppendChild($description_node)
    
    $pubdate = "Sun, 06 Sep 2009 16:20:00 +0000" # musi byc RFC standard date 

    $pubdate_note = $xml.CreateElement("pubDate") 
    $pubdate_note.AppendChild($xml.CreateTextNode($pubDate))
    $item.AppendChild($pubdate_note)    

    $channel.AppendChild($item)

}

$XmlWrSetting = [System.Xml.XmlWriterSettings]::new()
$XmlWrSetting.Encoding = [System.Text.Encoding]::UTF8
$XmlWrSetting.Indent = $true

$writer = [System.Xml.XmlWriter]::Create("C:\Temp\test.xml",$XmlWrSetting)

$xml.Save($writer)

$writer.Close()
