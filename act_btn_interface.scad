// ESPs should each have a hardcoded ID, and each btn+led should be numbered. That way we don't hardcode anything and can make changes on the server side.
// Battery button- stay online/connected to WS and see how long battery lasts
btns = 5;
// Potentially add indicator lights as a top row?
// * Standalone LED (just battery with colored LED + on/off switch?) always on, connect to server websocket. Color can be changed via POST - Usually off- yellow while running change to green when a script is done
// * Also have a similar connection with the LEDs- programmable via Jarvis. Do not hardcode LED names and data in the ESP. Just give them hard coded ids in the beginning.
// Refactor btn code to submit an id per btn so that the changes are done on Portfolio rather than hardware.
// Maybe allow a second layer for 10 btns?
// Have a slot on the front where we can put a "coin" with the logo of the thing
// Expandable based on above number, ideally with a "1" the ESP is directly underneath the btn
