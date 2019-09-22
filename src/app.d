import std.stdio;
import std.socket;
import std.file;
import std.conv;
import std.string;
import core.thread;
import dlangui;
import Settings;
<<<<<<< HEAD
import core.thread;
import vibe.core.net;
=======
>>>>>>> 37f08e771240d42f83656c13fb1b59e399ccf56b

mixin APP_ENTRY_POINT;

class FrameChat : AppFrame
{
	EditBox rtb;
	EditLine tbx;
	Socket soc;
	Button btn1;
<<<<<<< HEAD
	bool Connected = false;
=======
	ToolBar tb;
>>>>>>> 37f08e771240d42f83656c13fb1b59e399ccf56b
	this()
	{
	}

	enum ActionCode : int
	{
		Exit = 1,
		Settings,
		Connect,
		Disconnect,
		Help,
		Send,
	}

	enum DataFromFile : int
	{
		Ip = 0,
		RPort,
		Name,
		LPort,
	}

	const Action ACTION_CONNECT = new Action(ActionCode.Connect,
			"MENU_ICON_CONNECT"c, "offline_red16"c);
	const Action ACTION_DISCONNECT = new Action(ActionCode.Disconnect,
			"MENU_ICON_DISCONNECT"c, "online_green16"c);
	const Action ACTION_SETTINGS = new Action(ActionCode.Settings,
			"MENU_ICON_SETTINGS"c, "settings16"c);
	const Action ACTIONS_HELP = new Action(ActionCode.Help, "MENU_ICON_HELP"c, "help16"c);
	const Action ACTIONS_SEND = new Action(ActionCode.Send, "MENU_ICON_SEND"c, "send16"c);
	const ACTION_DISABLED = ActionState(false, true, false);

	override protected void initialize()
	{
		_appName = "DTchat";
		super.initialize();
	}

	override protected Widget createBody()
	{
		TableLayout res = new TableLayout(); // TabWidget tabs = new TabWidget("TABS");
		HorizontalLayout Line1 = new HorizontalLayout();
		Line1.layoutWidth = FILL_PARENT;
		Line1.layoutHeight = FILL_PARENT;
		int x = 645;
		int y = 400;
		rtb = new EditBox("rtb1", null, ScrollBarMode.Invisible, ScrollBarMode.Invisible);
		rtb.readOnly(true);
		rtb.minHeight(y); // rtb.minWidth(x);
		rtb.layoutWidth = x;
		Line1.addChild(rtb);
		HorizontalLayout Line2 = new HorizontalLayout();
		Line2.layoutWidth = FILL_PARENT;
		tbx = new EditLine("tbx", null);
		tbx.minWidth(x - 30);
		ImageButton btnSend = new ImageButton(ACTIONS_SEND);
		Line2.addChild(tbx);
		Line2.addChild(btnSend);

		// tabs.addChild(rtb);
		// tabs.addChild(new VSpacer());
		// tabs.addChild(Line2);

		res.addChild(Line1);
		res.addChild(new HSpacer());
		res.addChild(Line2);
		soc = new TcpSocket();
		return res;
	}

	override protected ToolBarHost createToolbars()
	{

		ToolBarHost bar = new ToolBarHost();
		
		tb = bar.getOrAddToolbar("Standard");
		ToolBarImageButton connector = new ToolBarImageButton(ACTION_CONNECT);
		connector.click = (Widget wid) => ChangeIcon(wid);
		tb.addChild(connector);
		tb.addButtons(ACTION_SETTINGS, ACTIONS_HELP);

		return bar;
	}

	override bool handleAction(const Action act)
	{
		if (act)
		{
			switch (act.id)
			{
			case ActionCode.Send:
				string[] tmp = ReadDataFromFile();
				AddLine(to!string(tbx.text()), tmp[DataFromFile.Name]);
				tbx.text("");
				tbx.setFocus();
				return true;
			case ActionCode.Connect:
				if (!exists("settings.data"))
				{
					window.showMessageBox(UIString.fromRaw("Connect error"d),
							UIString.fromRaw("Go in settings for value to use"d));
					return true;
				}
				else
				{
<<<<<<< HEAD

					
=======
					// act.state = ACTION_DISABLED;
					ToolBarImageButton tmp = cast(ToolBarImageButton)tb.childById("MENU_ICON_CONNECT"c);
					tmp.drawableId("online_green16"c);
					// ConnectToChat();
>>>>>>> 37f08e771240d42f83656c13fb1b59e399ccf56b
					return true;
				}
			case ActionCode.Settings:
				Window tmp = Platform.instance.createWindow("Settings",
						null, !WindowFlag.Resizable, 300, 300);
				static if (BACKEND_GUI)
					tmp.windowIcon = drawableCache.getImage("settings32");

				tmp.mainWidget = new FrameSettings();
				tmp.show();
				// window.showMessageBox(UIString.fromRaw("Settings"d), UIString.fromRaw("TODO"d));
				return true;
			case ActionCode.Help:
				window.showMessageBox(UIString.fromRaw("Help"d),
						UIString.fromRaw("Voici l'aide"d));
				return true;
			default:
				return super.handleAction(act);
			}
		}

		return false;
	}

	void ConnectToChat()
	{
		// Socket soc1 = new TcpSocket();
		string[] tmp = ReadDataFromFile();

		try
		{
			Thread tListener = new Thread(&EnabledListener);
			tListener.start();
		}
		catch (SocketException sex)
		{
			window.showMessageBox("Socket error"d, dtext(sex.msg));
		}
		catch (Exception ex)
		{
			window.showMessageBox("Error"d, dtext(ex.msg));
		}
		// try
		// {
		// 	// InternetAddress addr = new InternetAddress(tmp[DataFromFile.Ip],
		// 	// 		to!ushort(tmp[DataFromFile.RPort])); // InternetAddress addr1 = new InternetAddress("127.0.0.1", to!ushort(tmp[4]));

		// 	// soc.blocking = false;
		// 	// soc.bind(new InternetAddress(to!ushort(tmp[DataFromFile.LPort])));
		// 	// soc.listen(1);

		// 	while (true)
		// 	{
		// 		Socket client = soc.accept();
		// 		char[1024] buf;
		// 		auto recv = client.receive(buf);
		// 		window.showMessageBox("Message"d, dtext(buf));
		// 	}
		// 	// soc[0].connect(addr);

		// }
		// catch (SocketException ex)
		// {
		// 	window.showMessageBox(UIString.fromRaw("Error"), UIString.fromRaw(ex.msg));
		// }
		// catch (Exception ex)
		// {
		// 	window.showMessageBox(UIString.fromRaw("Error"), UIString.fromRaw(ex.msg));
		// }
	}

	bool ChangeIcon(Widget wid)
	{
		if (!Connected)
		{
			ToolBarImageButton tmp = cast(ToolBarImageButton) wid;
			tmp.drawableId("online_green16");
			Connected = true;
			ConnectToChat();
		}
		else
		{
			ToolBarImageButton tmp = cast(ToolBarImageButton) wid;
			tmp.drawableId("offline_red16");
			Connected = false;
		}
		return true;

	}

	void EnabledListener()
	{
		string[] tmp = ReadDataFromFile();
		Socket server = new TcpSocket();
		server.blocking(true);
		server.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);
		server.bind(new InternetAddress(to!ushort(tmp[DataFromFile.LPort])));
		server.listen(1);

		while (true)
		{
			Socket client = server.accept();

			while (client.isAlive())
			{
				char[] buffer;
				auto received = client.receive(buffer);
				// enum header = "HTTP/1.0 200 OK\nContent-Type: text/html; charset=utf-8\n\n";

				// string response = header ~"\n";
				// AddLine(to!string(buffer), "User");
				client.send("salut");
			}

			client.shutdown(SocketShutdown.BOTH);
			client.close();
		}
	}

	// void EnabledConnection(TcpSocket soc)
	// {
	// 	soc.write(cast(ubyte[]) "ceci est un test");
	// }

	string[] ReadDataFromFile()
	{
		string[] result;
		if (exists("settings.data"))
		{
			File f = File("settings.data", "r");
			string ln = "";
			int i = 0;
			while ((ln = f.readln()) !is null)
			{
				result ~= chomp(ln);
				i += 1;
			}
		}
		return result;
	}

	void AddLine(string value, string username)
	{
		rtb.text(dtext(rtb.text) ~ dtext(chomp(username)) ~ " : " ~ dtext(value) ~ "\n");
	}

}

extern (C) int UIAppMain(string[] args)
{
	//dlangui.core.logger.LogLevel.Log.setLogLevel(LogLevel.Fatal);
	embeddedResourceList.addResources(embedResourcesFromList!("resources.list")());

	Platform.instance.uiLanguage = "en";
	Platform.instance.uiTheme = "theme_default";

	Window window = Platform.instance.createWindow("DTchat", null, WindowFlag.Resizable, 500, 400);

	static if (BACKEND_GUI)
		window.windowIcon = drawableCache.getImage("icon32");

	window.mainWidget = new FrameChat();
	window.show();
	return Platform.instance.enterMessageLoop();
}
