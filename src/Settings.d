module Settings;
import dlangui.core.settings;
import std.socket;
import std.conv;
import std.stdio;
import std.file;
import dlangui;

class FrameSettings : AppFrame
{

    const Action ACTION_VALIDATE = new Action(ActionCode.Valide,
            "MENU_ACTION_VALIDATE"c, "Validate"c);


    EditLine tbx1,tbx2,tbx3,tbx4;

    this()
    {

    }

    enum ActionCode : int
    {
        Valide = 1,
    }

    override protected void initialize()
    {
        _appName = "Settings";
        super.initialize();
        
    }

    override protected Widget createBody()
    {
        TableLayout res = new TableLayout();

        HorizontalLayout line1 = new HorizontalLayout();
        TextWidget txt1 = new TextWidget("txt1", "Address of connection : "d);
        tbx1 = new EditLine("tbx1", ""d);
        tbx1.minWidth(100);
        Widget[] tmp = [txt1, tbx1];
        line1.addChildren(tmp);

        HorizontalLayout line2 = new HorizontalLayout();
        TextWidget txt2 = new TextWidget("txt2", "Port of connection (4321 default) : "d);
        tbx2 = new EditLine("tbx2", ""d);
        tbx2.minWidth(100);
        tmp = [txt2, tbx2];
        line2.addChildren(tmp);

        HorizontalLayout line3 = new HorizontalLayout();
        TextWidget txt3 = new TextWidget("txt3", "Username : "d);
        tbx3 = new EditLine("tbx3", ""d);
        tbx3.minWidth(100);
        tmp = [txt3, tbx3];
        line3.addChildren(tmp);

        HorizontalLayout line4 = new HorizontalLayout();
        TextWidget txt4 = new TextWidget("txt4", "Port to open for connection : "d);
        tbx4 = new EditLine("tbx4", ""d);
        tbx4.minWidth(100);
        tmp = [txt4, tbx4];
        line4.addChildren(tmp);

        HorizontalLayout line5 = new HorizontalLayout();
        line5.addChild(new Button(ACTION_VALIDATE));

        res.addChild(line1);
        res.addChild(new HSpacer());
        res.addChild(line2);
        res.addChild(new HSpacer());
        res.addChild(line3);
        res.addChild(new HSpacer());
        res.addChild(line4);
        res.addChild(new HSpacer());
        res.addChild(line5);
        ReadDataFromFile();
        return res;
    }

    override bool handleAction(const Action act)
    {
        if (act)
        {
            switch (act.id)
            {
            case ActionCode.Valide:
                SaveDataToFile();
                window.close();
                return true;

            default:
                return super.handleAction(act);
            }
        }

        return false;

    }


    void ReadDataFromFile()
    {
        if(exists("settings.data"))
        {
            File f = File("settings.data","r");
            string ln = "";
            int i = 0;
            while((ln = f.readln()) !is null)
            {
                switch(i)
                {
                    case 0: 
                    tbx1.text(dtext(ln));
                    break;
                    case 1: 
                    tbx2.text(dtext(ln));
                    break;
                    case 2: 
                    tbx3.text(dtext(ln));
                    break;
                    case 3: 
                    tbx4.text(dtext(ln));
                    break;
                    default:
                    window.close();
                    break;
                }
                i+=1;

            }
        }
    }

    void SaveDataToFile()
    {
        if(!exists("settings.data"))
        {
            File f = File("settings.data","w");
            f.write(tbx1.text ~ "\n");
            f.write(tbx2.text ~ "\n");
            f.write(tbx3.text ~ "\n");
            f.write(tbx4.text);
        }
    }
}
