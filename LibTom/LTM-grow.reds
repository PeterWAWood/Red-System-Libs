Red/System [
  Purpose:	"Add space for more digits to a mp-int"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{https://github.com/red/red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-grow: func [
	"Add space for more digits to a mp-int"
	mp-int				[LTM-int!]			"The integer to be expanded"
	size				[integer!]			"The desired size of the mp-int"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		tmp				[LTM-digit-ptr!]
][
	
	;; increase the size of mp-int if the requested size is greater than its
	;; current size
	if mp-int/alloc < size [
	
		;; ensure that there are always at least LTM-PREC digits empty 
		LTM-pad-size(size)
	
		;; re-allocate the digit array
		;;  the required space is allocated to a temporary variable first
		;;	so that if there is a problem the original array is not lost
		tmp: allocate size
		if tmp = as LTM-digit-ptr! 0 [return LTM-MEM]
		
		;;  copy the existing data from mp-digit to tmp so that mp-digit can be
		;;   safely freed
		copy-memory tmp mp-int/mp-digit mp-int/alloc
		free mp-int/mp-digit
		mp-int/mp-digit: tmp
		
		;; zero excess digits and set alloc
		LTM-zero-set(mp-int/mp-digit mp-int/alloc size)
		mp-int/alloc: size

	]
	LTM-OKAY
]
