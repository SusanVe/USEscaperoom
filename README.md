# USEscaperoom The Plate - group 11
To view our user API one has to open the “ThePlateSender” where our API works as follows:

To connect to another module, our module has to receive an input in the form of a String, and this value should be given to the variable ‘string’. The input can be a word, with consecutive letters, but also a sentence with spaces in between. 

Word input: “input”
Sentence input: “this is my input”

It is important that the message sent is send in lower case letters, as ThePlate is not able to output a distinction in upper and lower case letters. 

The message will be sent to our API handler by using an OOCSICall. This call calls our ThePlateReceiver API, and sends the corresponding data by means of .data(“stringCode”, string);

By making use of call.hasRepsonse a success message will be outputted when our receiver API has received the message. 

The channel name for this module is “ThePlate”
Our API handles the message in order to be able to send this to the Arduino. The message sent is converted into seperate outputs, where each letter or integer is sent after each other, but with a delay. This delay ensures that the user(s) will be able to distinguish which component is vibrating and how many vibrations were outputted. 

# Extensions
Currently the message is only outputted once, if the message is supposed to be outputted continuously this can be done by deleting the noLoop(); operation. When one wants this continuous message to stop depends on how ThePlate will be used. To correctly implement this, feel free to contact us.  

In the extension of our module, if this is requested, the input can be extended to also receive number input. Number input will be outputted like a traditional phone keypad, where every vibrating component will vibrate once to indicate the corresponding number. The number(s) can be received as an Integer, but will be transformed to a string for the convenience of our module using:

String stringNumber = Integer.ToString(number);

Where ‘number’ is the sent Integer value. 
