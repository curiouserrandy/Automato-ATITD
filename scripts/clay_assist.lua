-- Clay gatherer by Lyo
-- Intended as an assist; movement is done manually.  The number of jugs 
-- is prompted for at the beginning.  Then the macro cycles between filling 
-- the jugs (when it sees a water icon) and clicking on the clay icon (while
-- it computes there are still filled jugs).

dofile("screen_reader_common.inc");
dofile("ui_utils.inc");

WaterJugs = 0;
WaterFilled = 0;
waterDelay = 500;

function doit()
	while WaterJugs < 1 do
		WaterJugs = promptNumber("How many jugs?");
	end

	askForWindow("Start with empty jugs.  As you move the jugs will be filled (if empty) and clay clicked (if jugs non-empty).");

	local buttons;
        while 1 do
	    srReadScreen();
	    if WaterFilled < 1 then
		statusScreen("Looking for water ...");
		buttons = findAllImages("water.png");
		if #buttons > 0 then
		    srClickMouseNoMove(buttons[1][0]+9, buttons[1][1]+9, 0);
		    lsSleep(200);
	    	    srReadScreen();
		    buttons = findAllImages("maxButton.png");
		    if #buttons > 0 then
		        srClickMouseNoMove(buttons[1][0]+9, buttons[1][1]+9, 0);
		        WaterFilled = WaterJugs;
		    end
		end
	    else
	        statusScreen("Looking for clay, " .. WaterFilled .. "water left ...");
		buttons = findAllImages("clay.png");
		if #buttons > 0 then
		    srClickMouseNoMove(buttons[1][0]+9, buttons[1][1]+9, 0);
		    WaterFilled = WaterFilled - 1;
		end
	    end
	    lsSleep(200);
	end
end

	    