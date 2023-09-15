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