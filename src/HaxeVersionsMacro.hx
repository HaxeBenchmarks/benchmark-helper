
import haxe.macro.Compiler;
import haxe.macro.Expr;

class HaxeVersionsMacro {
	#if macro
	public static function mapOutput2Target():String {
		var output = Compiler.getOutput();

		if (~/\.n$/.match(output)) {
			return "Neko";
		}
		if (~/\.es6\.js$/.match(output)) {
			return "NodeJS (ES6)";
		}
		if (~/\.js$/.match(output)) {
			return "NodeJS";
		}
		if (~/\.hl$/.match(output)) {
			return "Hashlink";
		}
		if (~/\.c$/.match(output)) {
			return "Hashlink/C";
		}
		if (~/cpp$/.match(output)) {
			return "C++";
		}
		if (~/cs$/.match(output)) {
			return "C#";
		}
		if (~/java$/.match(output)) {
			return "Java";
		}
		if (~/jvm$/.match(output)) {
			return "JVM";
		}
		if (~/php$/.match(output)) {
			return "PHP";
		}
		if (~/\.py$/.match(output)) {
			return "Python";
		}
		return "eval";
	}
	#end

	macro public static function macroMapOutput2Target():Expr {
		return macro $v{mapOutput2Target()};
	}
}
