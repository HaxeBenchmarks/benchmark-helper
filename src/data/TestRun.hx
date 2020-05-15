package data;

typedef ArchivedResults = Array<TestRun>;

typedef TestRun = {
	var haxeVersion:String;
	var date:String;
	var targets:Array<TargetResult>;
}

typedef TargetResult = {
	var name:String;
	var time:Float;
	var compileTime:Null<Float>;
	@:optional var status:ResultStatus;
}

enum DatasetType {
	Haxe3;
	Haxe4;
	HaxeNightly;
}

abstract TimeValue(Float) to Float {
	function new(value:Float) {
		this = value;
	}

	@:from
	public static function fromFloat(value:Null<Float>):Null<TimeValue> {
		if (value == null) {
			return null;
		}
		return new TimeValue(Math.round(value * 1000) / 1000);
	}
}

enum abstract ResultStatus(Int) {
	var Success = 0;
	var CompileFailed = 1;
	var RunFailed = 2;
	var VerifyFailed = 3;
}

typedef ArchivedResultsV1 = Array<TestRunV1>;

typedef TestRunV1 = {
	var haxeVersion:String;
	var date:String;
	var targets:Array<TargetResultV1>;
}

typedef TargetResultV1 = {
	var name:String;
	var inputLines:Int;
	var outputLines:Int;
	var time:Float;
}
