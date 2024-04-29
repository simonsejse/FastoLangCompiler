all:
	dotnet build Fasto

clean:
	rm -rf Fasto/bin Fasto/obj
	rm -f Fasto/Parser.fs Fasto/Parser.fsi Fasto/Parser.fsyacc.output Fasto/Lexer.fs
