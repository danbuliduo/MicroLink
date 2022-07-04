.pragma library
//获取当前时间方法
function dateTime(string){
    return Qt.formatDateTime(new Date(),string)
}
//字符转时间戳
function str2time(string){
    var times=string.substring(0,19)
    times=string.replace(/'-/g,"/");
    return new Date(times).getTime()
}

//判断obj是否为JS数组
function isArray(object) {
    const toString = Object.prototype.toString
    const isArray = Array.isArray || function (arg) { return toString.call(arg) === '[object Array]' }
    return isArray(object)
}

//http请求方法
function request(URL){
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log('HEADERS_RECEIVED')
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            console.log('DONE',xhr.responseText.toString())
            //var object = JSON.parse(xhr.responseText.toString())
            //console.log(JSON.stringify(object,null,4))
        }
    }
    xhr.open("GET", URL)
    xhr.send()
}

