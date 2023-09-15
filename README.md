# AutoHotkey x ntfy
This is a simple class to send push notifications to your devices using [AutoHotkey](https://www.autohotkey.com/) via [ntfy](https://github.com/binwiederhier/ntfy). There's a version for AutoHotkey v1 and AutoHotkey v2.

### Class usage
1. Create an instance of `Ntfy`, passing in the ntfy "topic" (your url) as the parameter.
2. Call `add()` from the instance, passing in the header and its value as the parameters. Check out the [docs](https://docs.ntfy.sh/publish/) for the comprehensive list of headers. Repeat this step until you've added all the desired customizations.
3. Call `send()` from the instance, passing in the notification's body (i.e., the notification's text) as the parameter.

**IMPORTANT:** Since anyone can use "your" ntfy topic url, it is recommended to use a randomized url (it's basically a password).

### Usage demonstration for AutoHotkey v1
See **ntfy-v1.ahk** for the class used in this demonstration.

```
; Setting the ntfy topic
; The maximum number of characters for the topic is 64.
ntfyUrl := "https://ntfy.sh/testpage"

; This example sends a maximum priority notification to your devices,
; making it ring and vibrate, with a "My Unique Title" title
; and a "Sent with AHK v1." as the notification's text content.
n := new Ntfy(ntfyUrl)
    .add("Title", "My Unique Title")
    .add("Priority", "5")
    .send("Sent with AHK v1.")

; Alternatively, if you want to get the server's response...
n := new Ntfy(ntfyUrl)
    .add("Title", "My Unique Title")
    .add("Priority", "5")
serverResponse := n.send("Sent with AHK v1.")
Msgbox % serverResponse

; This example will send a default priority notification to your devices,
; with a horse and a unicorn emoji before the title of the notification
; and a "Title with emojis." as the notification's text content.
n := new Ntfy(ntfyUrl)
    .add("Title", "My Unique Title")
    .add("Priority", "3")   ; Default priority
    .add("Tags", "horse,unicorn")
    .send("Title with emojis.")

class Ntfy
{
    ntfyObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")

    __New(url)
    {
        this.ntfyObj.Open("POST", url, false)
    }

    add(header, value)
    {
        this.ntfyObj.SetRequestHeader(header, value)
        return this
    }

    ; Returns the server's response in JSON format.
    ; You may use various AutoHotkey libraries to work with it.
    send(value)
    {
        this.ntfyObj.Send(value)
        this.ntfyObj.WaitForResponse()
        return this.ntfyObj.ResponseText
    }
}
```

### Usage demonstration for AutoHotkey v2
The only difference between v1 and v2 is that instance declarations in v2 don't require the `new` keyword anymore.

AutoHotkey v1 instance declaration:
```
n := new Ntfy(ntfyUrl)
```
AutoHotkey v2 instance declaration:
```
n := Ntfy(ntfyUrl)
```

See **ntfy-v2.ahk** for the class used in this demonstration.
```
; Setting the ntfy topic
; The maximum number of characters for the topic is 64.
ntfyUrl := "https://ntfy.sh/testpage"

; This example sends a maximum priority notification to your devices,
; making it ring and vibrate, with a "My Unique Title" title
; and a "Sent with AHK 2." as the notification's text content.
n := Ntfy(ntfyUrl)
    .add("Title", "My Unique Title")
    .add("Priority", "5")
    .send("Sent with AHK v2.")

; Alternatively, if you want to get the server's response...
n := Ntfy(ntfyUrl)
    .add("Title", "My Unique Title")
    .add("Priority", "5")
serverResponse := n.send("Sent with AHK v2.")
Msgbox serverResponse

; This example will send a default priority notification to your devices,
; with a horse and a unicorn emoji before the title of the notification
; and a "Title with emojis." as the notification's text content.
n := Ntfy(ntfyUrl)
    .add("Title", "My Unique Title")
    .add("Priority", "3")   ; Default priority
    .add("Tags", "horse,unicorn")
    .send("Title with emojis.")

class Ntfy
{ 
    ntfyObj := ComObject("WinHttp.WinHttpRequest.5.1")

    __New(url)
    {
        this.ntfyObj.Open("POST", url, false)
    }

    add(header, value)
    {
        this.ntfyObj.SetRequestHeader(header, value)
        return this
    }

    ; Returns the server's response in JSON format.
    ; You may use various AutoHotkey libraries to work with it.
    send(value)
    {
        this.ntfyObj.Send(value)
        this.ntfyObj.WaitForResponse()
        return this.ntfyObj.ResponseText
    }
}
```