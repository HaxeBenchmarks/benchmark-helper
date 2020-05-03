import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import data.TestRun;
import json2object.JsonParser;

class ConvertOld2New {
	public static function main() {
		if (Sys.args().length <= 0) {
			Sys.exit(-1);
		}
		var fileNameOld:String = Sys.args()[0];
		if (!FileSystem.exists(fileNameOld)) {
			Sys.exit(-1);
		}
		var parserOld:JsonParser<ArchivedResultsV1> = new JsonParser<ArchivedResultsV1>();
		var oldContent:String = File.getContent(fileNameOld);
		var oldData:ArchivedResultsV1 = parserOld.fromJson(oldContent, fileNameOld);

		var newData:ArchivedResults = [];

		for (oldResult in oldData) {
			newData.push({
				haxeVersion: oldResult.haxeVersion,
				date: oldResult.date,
				targets: convertTargetResults(oldResult.targets)
			});
		}

		var fileNameNew:String = 'converted.$fileNameOld';

		File.saveContent(fileNameNew, Json.stringify(newData));
	}

	static function convertTargetResults(targets:Array<TargetResultV1>):Array<TargetResult> {
		var newTargets:Array<TargetResult> = [];
		for (target in targets) {
			newTargets.push({
				name: mapTargetName(target.name),
				time: target.time,
				compileTime: null
			});
		}

		return newTargets;
	}

	static function mapTargetName(name:String):String {
		return switch (name) {
			case "eval":
				"Eval";
			case "Hashlink":
				"HashLink";
			case "Hashlink/C":
				"HashLink/C";
			case _:
				name;
		}
	}
}
