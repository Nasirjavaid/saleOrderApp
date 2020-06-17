class APIResponce<T>{

T data;
bool error;
String errorMessage;
APIResponce({this.data,this.errorMessage ,this.error = false});

}