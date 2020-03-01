import haxe.Json;
import haxe.io.Bytes;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import data.CSVReader;
import data.TestRun;
import json2object.JsonParser;

class CsvToJson {
	public static function main() {
		archiveRun(parseResults());
	}

	static function archiveRun(testRun:TestRun) {
		var fileName:String = "results/results.json";
		if (testRun.targets.length <= 0) {
			Sys.println("no target data found");
			return;
		}

		var archiveContent:String = "";
		var archivedData:ArchivedResults = [];
		if (FileSystem.exists(fileName)) {
			var archiveContent:String = File.getContent(fileName);
			var parser:JsonParser<ArchivedResults> = new JsonParser<ArchivedResults>();
			archivedData = parser.fromJson(archiveContent, fileName);
		}

		archivedData.push(testRun);
		archiveContent = Json.stringify(archivedData, "  ");
		File.saveContent(fileName, archiveContent);
	}

	static function parseResults():TestRun {
		var testRun:TestRun = {
			haxeVersion: getHaxeVersion(),
			date: '${Date.now()}',
			targets: []
		};

		var results:String = File.getContent("results.csv");
		var reader:CSVReader = new CSVReader(results);
		var row:Array<String>;
		while (reader.hasMore()) {
			row = reader.nextLine();
			if (row.length != 5) {
				continue;
			}
			testRun.targets.push({
				name: row[0],
				inputLines: Std.parseInt(row[2]),
				outputLines: Std.parseInt(row[3]),
				time: Std.parseFloat(row[4])
			});
		}

		return testRun;
	}

	static function getHaxeVersion():String {
		var proc:Process = new Process("haxe -version");
		var exitCode:Int = proc.exitCode();
		var bytesOut:Bytes = proc.stdout.readAll();
		var bytesErr:Bytes = proc.stderr.readAll();
		proc.close();

		var version:String = StringTools.trim(bytesOut.toString());
		if (version == "") {
			version = StringTools.trim(bytesErr.toString());
		}
		return version;
	}
}
