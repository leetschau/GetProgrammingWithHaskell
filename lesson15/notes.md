# 15.4 The one-time pad

There's a problem in `encoderDecoder`.
`myPad` in `encoderDecoder` works as a `key`.
Once its value (here it's `"Shhhhhh"`) is gotten by the third people,
he/she can decode the message.

So how to transfer the key safely between the sender and receiver?
