{ ... }:
{
  plugins.auto-save = {
   enable = true;
  settings = { 
  execution_message.enabled = true;
    trigger_events.immediate_save = [ "BufLeave" ];
  };
  };
}
