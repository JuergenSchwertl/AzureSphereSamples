#include "intercore_messages.h"

const InterCoreMessageHeader InterCoreMessage_Ping = { .Text = "PING" };
const InterCoreMessageHeader InterCoreMessage_PingResponse = { .Text = "ping" };
const InterCoreMessageHeader InterCoreMessage_ReceivedResponse = { .Text = "recv" };
const InterCoreMessageHeader InterCoreMessage_BlinkInterval = { .Text = "BLNK" };

