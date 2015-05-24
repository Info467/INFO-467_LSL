 integer SECRET_NUMBER=1596834957202357;
 string SECRET_STRING="iSchoolisSOcool";
 key http_request_id;
 
xrequest(string url, list l)
{
    integer i;
    string body;
    integer len=llGetListLength(l) & 0xFFFE; // make it even
    for (i=0;i<len;i+=2)
    {
        string varname=llList2String(l,i);
        string varvalue=llList2String(l,i + 1);
        if (i>0) body+="&";
        body+=llEscapeURL(varname)+"="+llEscapeURL(varvalue);
    }
    string hash=llMD5String(body+llEscapeURL(SECRET_STRING),SECRET_NUMBER);
    http_request_id = llHTTPRequest(url+"?hash="+hash,[HTTP_METHOD,"POST",HTTP_MIMETYPE,"application/x-www-form-urlencoded"],body);
}
 
default {
    collision_start(integer c) {
        string msg = llGetDisplayName(llDetectedKey(0));
        string date = llGetDate();
        list post = [msg, date];
        xrequest("http://students.washington.edu/arm38/LSLboard.php", post);
    }
}