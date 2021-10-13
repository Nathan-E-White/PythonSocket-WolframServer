#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Input:: *)
(*sock = SocketOpen["127.0.0.1:51859"]*)


(* ::Input:: *)
(*sock["Properties"]*)


(* ::Input:: *)
(*sock["ConnectedClients"]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Clear[SocketWrite];*)
(*SocketWrite /: SocketWrite[sObj_SocketObject, data_]:=WriteString[sObj, data];*)


(* ::Input:: *)
(*SocketWrite[sock["ConnectedClients"][[1]], "11111"]*)


(* ::Input:: *)
(*RealDigits[1.0000]*)
(*FromDigits[{{1,0,0,0,0,0,0,0}, 1}]*)


(* ::Input:: *)
(*testData=QuantityMagnitude@FinancialData["NYSE:XOM", "OHLCV", DatePlus[Today, -10]]*)


(* ::Input:: *)
(*rxtChartData = Import["https://cdn.rawgit.com/rrag/react-stockcharts/master/docs/data/MSFT.tsv"];*)


(* ::Input:: *)
(*TableForm@rxtChartData[[1;;5]]*)


(* ::Input:: *)
(*testData["Path"]*)


(* ::Input:: *)
(*Clear[ProcessDatapoint];*)
(*ProcessDatapoint /: ProcessDatapoint[{*)
(*tstamp_Integer, {*)
(*open_?NumericQ, *)
(*high_?NumericQ, *)
(*low_?NumericQ, *)
(*close_?NumericQ, *)
(*volume_?NumericQ*)
(*}}] := {*)
(*"Time" -> DateString[tstamp,{"Year", "-","Month","-", "Day"}],*)
(*"Open" -> ToString@open, *)
(*"High"->ToString@high, *)
(*"Low"->ToString@low, *)
(*"Close"->ToString@close,*)
(*"Volume"->ToString@volume*)
(*}*)


(* ::Input:: *)
(*Clear[dataPoints, jsonData];*)
(*dataPoints=ProcessDatapoint@@@Map[List,testData["Path"]];*)
(*jsonData = ExportString[#, "JSON"]& /@ dataPoints;*)


(* ::Input:: *)
(*Clear[jsonCn, jsonDs, pullData];*)
(*jsonCn = CreateDataStructure["Counter", 1];*)
(*jsonDs = CreateDataStructure["HashTable"];*)
(*Do[jsonDs["Insert", idx -> jsonData[[idx]]],{idx, 1, Length[jsonData]}]*)
(**)
(*pullData = Function[jsonDs["Lookup", Mod[jsonCn["Increment"], Length[jsonData]]]];*)


(* ::Input:: *)
(*ExportString[pullData[], "JSON", "Compact" -> True]*)


(* ::Input:: *)
(*Clear[SocketLoop, iSocketLoop];*)
(**)
(*SocketLoop::usage = "SocketLoop ...";*)
(*TaskEnvironment::usage = "TaskEnvironment is an option for SocketLoop that defines whether to run the socket loop job in a local kernal or the current session.";*)
(**)
(**)
(*Options[SocketLoop] = {*)
(*TaskEnvironment -> SessionSubmit*)
(*};*)
(**)
(*SocketLoop /: SocketLoop[*)
(*socket_SocketObject,*)
(*delay_?(Xor[DateObjectQ[#], QuantityQ[#]]&), *)
(*repeats_?IntegerQ,*)
(*options: OptionsPattern[]*)
(*] := Module[{*)
(*to, st, flg*)
(*},*)
(**)
(*st = ScheduledTask[SocketWrite[socket, ByteArray@pullData[]], {delay, repeats}];*)
(*to = List[*)
(*st, *)
(*HandlerFunctions-><|"ResultReceived"->Print|>,*)
(*HandlerFunctionsKeys -> "EvaluationResult"*)
(*];*)
(**)
(*flg[1] = OptionValue[TaskEnvironment] == Automatic;*)
(*flg[1] = flg[1] || OptionValue[TaskEnvironment] == Default;*)
(*flg[1] = flg[1] || OptionValue[TaskEnvironment] == SessionSubmit;*)
(*flg[2] = OptionValue[TaskEnvironment] == LocalSubmit;*)
(*flg[3] = Nor[flg[1], flg[2]];*)
(*Which[*)
(*flg[1], Return[SessionSubmit[Evaluate[Sequence @@ to]]],*)
(*flg[2], Return[LocalSubmit[Evaluate[Sequence @@ to]]],*)
(*flg[3], Message[SocketLoop::UnkTskEnv, OptionValue[TaskEnvironment]]*)
(*];*)
(*];*)
(**)
(*SocketLoop::UnkTskEnv = "Could not understand Task Environment option ``.";*)


(* ::Input:: *)
(*Clear[loopPause];*)
(*loopPause[1] = Quantity[1,"Seconds"];*)
(*loopCount = 10;*)
(*SocketLoop[sock["ConnectedClients"][[1]],loopPause[1], loopCount, TaskEnvironment->Automatic]*)
