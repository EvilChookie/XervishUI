function xUI_Chat_Setup()
  -- Hide the friends icon thing:
  QuickJoinToastButton:Hide();
  ChatFrameChannelButton:Hide();
  ChatFrameMenuButton:Hide();
  ChatFrame1ButtonFrame:Hide();

  -- Setup our width and height:
  ChatFrame1:SetWidth(400)
  ChatFrame1:SetHeight(132)

  -- Position the chat:
  ChatFrame1:ClearAllPoints()
  ChatFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 13)

  -- Save the chat settings (otherwise, doing something in the UI will save that over the addon, and all this gets ignored)
  ChatFrame1:SetUserPlaced(true)
end 

XervishUI:RegisterCallback("PLAYER_LOGIN", xUI_Chat_Setup)