red [
	Title:		"Share Analysis Test"
	Author:  	"Peter W A Wood"
	File: 	 	%share-analysis-test.red
	Purpose:	"Runs tests of share-analysis.red " 	
	Tabs:	 4
	
	Rights:  "Copyright (C) 2016 Peter W A Wood. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

do %../../../../Red/red/quick-test/quick-test.red

***start-run*** "Share Analysis Test"

do %share-analysis-core-test.red
do %share-analysis-view-test.red

***end-run***

unview
print ""