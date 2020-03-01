package macro;

import haxe.macro.Compiler;
import haxe.macro.Expr;

class HaxeVersionsMacro {
	#if macro
	static function mapOutput2Target():String {
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
		var output = Compiler.getOutput();

		if (~/\.n$/.match(output)) {
			return macro "Neko";
		}
		if (~/\.es6\.js$/.match(output)) {
			return macro "NodeJS (ES6)";
		}
		if (~/\.js$/.match(output)) {
			return macro "NodeJS";
		}
		if (~/\.hl$/.match(output)) {
			return macro "Hashlink";
		}
		if (~/\.c$/.match(output)) {
			return macro "Hashlink/C";
		}
		if (~/cpp$/.match(output)) {
			return macro "C++";
		}
		if (~/cs$/.match(output)) {
			return macro "C#";
		}
		if (~/java$/.match(output)) {
			return macro "Java";
		}
		if (~/jvm$/.match(output)) {
			return macro "JVM";
		}
		if (~/php$/.match(output)) {
			return macro "PHP";
		}
		if (~/\.py$/.match(output)) {
			return macro "Python";
		}
		return macro "eval";
	}
}
