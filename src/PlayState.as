package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSave;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class PlayState extends FlxState
	{
		[Embed(source="ch1_120x120_4.png")]
		private static const CH1_IMG:Class;
		
		[Embed(source="ch2.png")]
		private static const CH2_IMG:Class;
		
		[Embed(source="ch3.png")]
		private static const CH3_IMG:Class;
		
		[Embed(source="ch4.png")]
		private static const CH4_IMG:Class;
		
		[Embed(source = "ch5.png")]
		private static const CH5_IMG:Class;
		
		[Embed(source = "ch6.png")]
		private static const CH6_IMG:Class;
		
		[Embed(source = "ch7.png")]
		private static const CH7_IMG:Class;
		
		private var CH_BTN_IMG:Array = [CH1_IMG, CH2_IMG, CH3_IMG, CH4_IMG, CH5_IMG, CH6_IMG, CH7_IMG];
		
		[Embed(source = "bg.png")]
		private static const BG_IMG:Class;
		
		
		[Embed(source = "left_wall_30x300.png")]
		private static const LEFT_WALL_IMG:Class;
		
		[Embed(source = "right_wall_30x300.png")]
		private static const RIGHT_WALL_IMG:Class;
		
		[Embed(source = "win.png")]
		private static const WIN_IMG:Class;
		
		[Embed(source = "fingers.mp3")]
		private static const F_SND:Class;
		
		[Embed(source = "balls.mp3")]
		private static const B_SND:Class;
		
		private const TEN_SEC:int = 10 * G.FPS;
		
		private var a:A;
		public var seq:Array;
		
		private const MAX_CH_COUNT:int = 7;
		private var chCount:int;
		private var chArrived:int;
		private var chErr:int;
		public var chID:int;
		
		private var chGroup:FlxGroup;
		
		private var chBtnGroup:FlxGroup;
		private var chNumGroup:FlxGroup;
		public var chMarkGroup:FlxGroup;
		
		private var forwardAct:Act = new Act();
		private var waitForwardAct:Act = new Act();
		private var seqAct:Act = new Act();
		private var seq2Act:Act = new Act();
		private var backwardAct:Act = new Act();
		private var waitBackwardAct:Act = new Act();
		private var nextAct:Act = new Act();
		private var winAct:Act = new Act();
		
		private var am:ActM = new ActM();
		
		private var nextBtn:NextBtn;
		private var nextPressed:Boolean = false;
		
		private var timer:int;
		
		//private var info:FlxText;
		
		private var numBig:NumBig;
		
		private var win:FlxSprite;
		
		private var fSnd:FlxSound;
		private var bSnd:FlxSound;
		
		override public function create():void 
		{
			chCount = 2;
			chArrived = 0;
			chErr = 0;
			chID = 0;
			a = new A(chCount);
			seq = new Array();
			
			chGroup = new FlxGroup();
			for (var i:int = 0; i < MAX_CH_COUNT; ++i) {
				var ch:Ch = new Ch();
				ch.frame = i;
				ch.val = i;
				ch.p = this;
				ch.onForwardArrived = onArrived;
				ch.onBackwardArrived = onArrived;
				ch.onBackwardErrArrived = onErr;
				chGroup.add(ch);
				ch.kill();
			}
			
			chBtnGroup = new FlxGroup();
			chNumGroup = new FlxGroup();
			chMarkGroup = new FlxGroup();
			for (i = 0; i < MAX_CH_COUNT; ++i) {
				var b:ChBtn = new ChBtn();
				b.loadGraphic(CH_BTN_IMG[i] as Class, true, false, 120, 120);
				b.width *= 0.8;
				b.height *= 0.8;
				b.centerOffsets();
				b.val = i;
				b.setEnabled(false);
				chBtnGroup.add(b);
				
				var t:FlxText = new FlxText(0, 0, b.width, "");
				t.size = 32;
				t.color = FlxG.BLACK;
				t.alignment = "center";
				chNumGroup.add(t);
				
				var m:Mark = new Mark();
				chMarkGroup.add(m);
				
				b.t = t;
				b.m = m;
				b.p = this;
				
				b.kill();
				t.kill();
				m.kill();
			}
			
			numBig = new NumBig();
			numBig.x = 300;
			numBig.y = 400;
			numBig.visible = false;
			
			win = new FlxSprite(0, 0, WIN_IMG);
			win.x = 150 + (500 - win.width) / 2;
			win.y = 150 + (250 - win.height) / 2;
			win.visible = false;
			
			fSnd = FlxG.loadSound(F_SND);
			bSnd = FlxG.loadSound(B_SND);
			
			add(new FlxSprite(0, 0, BG_IMG));
			add(win);
			add(chBtnGroup);
			add(chNumGroup);
			add(chMarkGroup);
			add(chGroup);
			add(new FlxSprite(0, 200, LEFT_WALL_IMG));
			add(new FlxSprite(FlxG.width - 30, 200, RIGHT_WALL_IMG));
			add(numBig);
			
			forwardAct
			.setInit(forward_init)
			.setUpdate(forward_update)
			.setNext(forward_next);
			
			waitForwardAct
			.setNext(waitForward_next);
			
			seqAct
			.setInit(seq_init)
			.setUpdate(seq_update)
			.setNext(seq_next);
			
			seq2Act
			.setInit(seq2_init)
			.setUpdate(seq2_update)
			.setNext(seq2_next);
			
			backwardAct
			.setInit(backward_init)
			.setUpdate(backward_update)
			.setNext(backward_next);
			
			waitBackwardAct
			.setNext(waitBackward_next);
			
			nextAct
			.setInit(next_init)
			.setNext(next_next);
			
			winAct
			.setInit(win_init)
			.setUpdate(win_update)
			.setNext(win_next);
			
			am.init(forwardAct);
			
			/*
			info = new FlxText(0, 0, FlxG.width, "");
			info.size = 16;
			info.color = FlxG.BLACK;
			add(info);
			*/
			
			nextBtn = new NextBtn();
			nextBtn.callback = nextBtnCallback;
			add(nextBtn);
			nextBtn.kill();
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new MenuState());
			}
			super.update();
			
			am.update();
			
			/*
			var t:String = chArrived + "/" + chCount + " err:" + chErr + "\n" + int(timer / 30) + "\n[";
			for (var i:int = 0; i < chCount; ++i) {
				if (i > 0) t += " ";
				t += (a.getVal(i) + 1);
			}
			t += "]\n[";
			for (i = 0; i < chCount; ++i) {
				if (i > 0) t += " ";
				t += (seq[i] + 1);
			}
			t += "]";
			info.text = t;
			*/
		}
		
		private function onArrived():void
		{
			++chArrived;
		}
		
		
		private function onErr():void
		{
			++chErr;
		}
		
		private function nextBtnCallback():void
		{
			nextPressed = true;
		}
		
		// forward
		
		private function forward_init():void
		{
			var ch:Ch = chGroup.members[a.getVal(chID)];
			ch.init(Ch.FORWARD);
			timer = 0;
		}
		
		private function forward_update():void
		{
			++timer;
		}
		
		private function forward_next():Act
		{
			if (timer >= 30) {
				++chID;
				if (chID < chCount) {
					return forwardAct;
				} else {
					return waitForwardAct;
				}
			}
			return null;
		}
		
		// wait forward
		
		private function waitForward_next():Act
		{
			if (chArrived == chCount) {
				chArrived = 0;
				return seqAct;
			}
			return null;
		}
		
		// seq
		
		private function seq_init():void
		{
			timer = 0;
			numBig.frame = 10;
			numBig.visible = true;
			fSnd.play();
			for (var i:int = 0; i < chCount; ++i) {
				var b:ChBtn = chBtnGroup.members[i] as ChBtn;
				//b.reset(50 + 150 * i, b.y = 50);
				if (i < 4) {
					b.reset((FlxG.width - 460) / 2 + i * (b.width + 20), 30);
				} else {
					b.reset((FlxG.width - 340) / 2 + (i - 4) * (b.width + 20), 200);
				}
				b.setKey( -1);
				
				b.t.reset(b.x, b.y + b.height);
				
				b.m.reset(b.t.x + b.t.height, b.y + (b.width - b.m.width) / 2);
				b.m.visible = false;
			}
			for (i = 0; i < chCount; ++i) {
				seq[i] = -1;
			}
			chID = 0;
		}
		
		private function seq_update():void
		{
			++timer;
			if ((timer % G.FPS) == 0) {
				numBig.frame = 10 - int(timer / G.FPS);
				if (timer == TEN_SEC) {
					bSnd.play();
				} else {
					fSnd.play();
				}
			}
		}
		
		private function seq_next():Act
		{
			if (timer == TEN_SEC) {
				for (var i:int = 0; i < chCount; ++i) {
					(chBtnGroup.members[i] as ChBtn).setEnabled(false);
				}
				return seq2Act;
			}
			return null;
		}
		
		// seq 2
		
		private function seq2_init():void
		{
			timer = 0;
		}
		
		private function seq2_update():void
		{
			++timer;
		}
		
		private function seq2_next():Act
		{
			if (timer >= 30) {
				if (chID < chCount) {
					for (var i:int = 0; i < chCount; ++i) {
						var b:ChBtn = chBtnGroup.members[i] as ChBtn;
						if (b.getKey() < 0) {
							b.setKey(chID);
							++chID;
							break;
						}
					}
					return seq2Act;
				} else {
					chID = 0;
					numBig.visible = false;
					return backwardAct;
				}
			}
			return null;
		}
		
		// backward
		
		private function backward_init():void
		{
			timer = 0;
		}
		
		private function backward_update():void
		{
			++timer;
		}
		
		private function backward_next():Act
		{
			if (timer >= G.FPS) {
				var val:int = seq[chID];
				if ((chID == chCount) || (val == -1)) {
					return waitBackwardAct;
				} else {
					var ch:Ch = chGroup.members[a.getVal(chID)] as Ch;
					if (val == a.getVal(chID)) {
						ch.init(Ch.BACKWARD);
					} else {
						ch.init(Ch.BACKWARD_ERR);
					}
					++chID;
					return backwardAct;
				}
			}
			return null;
		}
		
		// wait backward
		
		private function waitBackward_next():Act
		{
			if ((chArrived + chErr) == chCount) {
				if ((chCount == MAX_CH_COUNT) && (chErr == 0)) {
					return winAct;
				} else {
					return nextAct;
				}
			}
			return null;
		}
		
		// next
		
		private function next_init():void
		{
			nextBtn.reset(300 + (200 - nextBtn.width) / 2, 400 + (200 - nextBtn.height) / 2);
		}
		
		private function next_next():Act
		{
			if (nextPressed) {
				nextPressed = false;
				nextBtn.kill();
				for (var i:int = 0; i < chCount; ++i) {
					var b:ChBtn = chBtnGroup.members[i] as ChBtn;
					b.kill();
					b.t.kill();
					b.m.kill();
				}
				if (chErr > 0) {
					if (chCount > 2) --chCount;
				} else {
					++chCount;
				}
				chArrived = 0;
				chErr = 0;
				chID = 0;
				a.shuffle(chCount);
				return forwardAct;
			}
			return null;
		}
		
		// win
		
		private function win_init():void
		{
			timer = 0;
		}
		
		private function win_update():void
		{
			++timer;
			if ((timer > G.FPS) && !win.visible) {
				win.visible = true;
				for (var i:int = 0; i < chCount; ++i) {
					var b:ChBtn = chBtnGroup.members[i] as ChBtn;
					b.kill();
					b.t.kill();
					b.m.kill();
				}
			}
		}
		
		private function win_next():Act
		{
			if (timer > 3 * G.FPS) {
				FlxG.switchState(new MenuState());
			}
			return null;
		}
		
	}

}