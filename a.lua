require("TSLib")
function comp(c1,c2)
	r1,g1,b1=intToRgb(c1)
	r2,g2,b2=intToRgb(c2)

	dr=math.abs(r1-r2)
	dg=math.abs(g1-g2)
	db=math.abs(b1-b2)

	return (256-math.max(dr,dg,db))/256*100
end

nLog(comp(0x564978, 0x403a56))