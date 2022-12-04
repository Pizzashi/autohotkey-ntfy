# AutoHotkey x ntfy
This is a simple class to send push notifications to your devices using [AutoHotkey](https://www.autohotkey.com/) via [ntfy](https://github.com/binwiederhier/ntfy).

### Class usage
1. Create an instance of `Ntfy`, passing in the ntfy "topic" (your url) as the parameter.
2. Call `add()` from the instance, passing in the header and its value as the parameters. Check out the [docs](https://docs.ntfy.sh/publish/) for the comprehensive list of headers. Repeat this step until you've added all the desired customizations.
3. Call `send()` from the instance, passing in the notification's body as the parameter.

### Usage demonstration
```
/*
* I recommend setting your own *randomized* url, since anyone
* can use this url to send push notifications to your devices.
*/
ntfyUrl := "https://ntfy.sh/testpage"

/*
* This will send a maximum priority notification to your phone (and other devices),
* making it ring and vibrate, with a "Title1" title and a "BodyContent1" as the
* notification's text content.
*/
ntfy := new Ntfy(ntfyUrl)
ntfy.add("Title", "Title1")
ntfy.add("Priority", "5")
ntfy.send("BodyContent1")

/*
* This will send a default priority notification to your phone (and other devices),
* with a horse and a unicorn emoji before the title (i.e., "[horse][unicorn]Title2"),
* and "BodyContent2" as the notification's text content. 
*/
ntfy := new Ntfy(ntfyUrl)
ntfy.add("Title", "Title2")
ntfy.add("Priority", "3") ; Default priority
ntfy.add("Tags", "horse,unicorn")
ntfy.send("BodyContent2")

class Ntfy
{
    __New(url)
    {
        this.oNotify := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        this.oNotify.Open("POST", url, false)
    }

    add(header, value)
    {
        this.oNotify.SetRequestHeader(header, value)
    }

    send(value)
    {
        this.oNotify.Send(value)
    }
}
```
