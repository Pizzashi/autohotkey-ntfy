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
