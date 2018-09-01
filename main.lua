require("TSLib")

function snapScreenToComputer()
	--截屏到共享目录
	os.execute("screencap -p /sdcard/Pictures/"..os.time()..".png")
end

function comp(c1,c2)
	--比较两个颜色，返回它们的相似度（0~100）
	r1,g1,b1=intToRgb(c1)
	r2,g2,b2=intToRgb(c2)

	dr=math.abs(r1-r2)
	dg=math.abs(g1-g2)
	db=math.abs(b1-b2)

	return (256-math.max(dr,dg,db))/256*100
end

function beforeUserExit()
	--用户主动退出脚本后执行的语句
	
	--用于获取目标跳台的最上边的点的横纵坐标的范围（减少循环次数以提高速度）
	--wLog("jump", "i: "..mini.." ~ "..maxi.."    ".."j: "..minj.." ~ "..maxj)
	wLog("jump","主动终止")
	closeLog("jump")
end

function get_center(x1)
	--该函数用来获取目标跳点的具体坐标，即小紫人要跳到的位置的坐标，其中x1为小紫人所在位置的横坐标

	--总体思路为：先获取目标跳台的最上面的点（第一个参考点），再以此参考点出发，找到目标跳台的两边的点（分别称之为第二、三个参考点），其中点即为所求点

	local count=0 --后面多次用到的计数器
	local flag=false --初始化反向扫描的flag为false
	local c0=getColor(1, 250) --初始化c0为屏幕坐标(1,250)处的颜色
	local x21,y21,x22,y22,xxx,c1,i,j
	--[[(x21,y21)和(x22,y22)两点的中点即为目标跳点的第一个参考点
	    xxx表示扫描过程中的真实当前横坐标（因为有时会反向扫描）
		c1是当前的颜色
		i, j是循环计数器（也用做坐标）]]

	j=410
	while (j<=630) do
		i=0
		while (i<=495) do
			if flag then --如果flag为true，则反向扫描
				xxx=615-i
			else
				xxx=i+120
			end
			c1=getColor(xxx, j) --获取当前颜色并存到c1

			--上一个颜色不能为紫色
			if comp(c0,0x403a56)>=86 and comp(c0,0x484848)<96 then 
				wLog("jump","上一个颜色是紫色: "..comp(c0,0x484848).."    "..xxx..","..j)
				lua_exit()
				mSleep(1000)
			end
			--如果当前颜色和上一个颜色不同
			if comp(c1,c0)<96 then
				wLog("jump","color is different: ("..xxx..","..j..","..string.format("%x",c1)..")".." 和 "..string.format("%x", c0))
				--如果当前颜色不是紫色（0x484848会被误认为是紫色）
				if comp(c1, 0x403a56)<86 or comp(c1,0x484848)>=96 then
					count=count+1
					wLog("jump","不是紫色："..(xxx).." "..j.." "..string.format("%x", c1))
					--找到了x21,y21
					if count==1 then
						x21,y21=xxx,j
						--带胶带的箱子特殊处理（其右面写有"LRQ"字符）
						if comp(c1,0xe1c78e)>=98 then
							return x21+1,y21+57
						end
						--绿色带耳朵的可爱的箱子（因为未知原因未跳到中心）
--						if comp(c1,0xbaf044)==100 then
--							return x21,y21+57
--						end
						--带光盘的箱子
						if comp(c1,0xd6d8ef)>=98  then
							return x21,y21+76
						end
						--带光盘的箱子（其左上写有“WUYU”字符，右下“JUTO”字符）
						if comp(c1,0x939393)>=98 then
							return x21+14,y21+66
						end
						--duang duang duang的箱子
						if comp(c1,0xf44f5e)>=98 then
							return x21,y21+57
						end
						--奶茶杯子
						if comp(c1,0x484848)>=96 then
							return x21+11,y21+31
						end
						--木板凳
						if comp(c1,0xd8b695)>=89 then
							wLog("jump","木板凳")
							return x21,y21+58
						end
						--白色箱子（其左面写有“WEDESIGN”字符）
						if comp(c1,0xe2e2e2)>=99 then
							return x21,y21+60
						end
						--泥色箱子（其右面写有“433天”字符）
						if comp(c1, 0x896a66)>=97 then
							return x21,y21+57
						end
					end
					if count>=2 then
						if j==y21 then
							xxx=(flag and xxx+1 or xxx-1) --对xxx进行微调
							x22,y22=xxx,j --找到了x22,y22
							goto found_top_point --跳转到后面
						else
							wLog("jump","error: j!=y21")
							lua_exit()
							mSleep(1000)
						end
					end
				--如果当前颜色是紫色
				else 
					--当小紫人在屏幕左边且flag==false时，改变flag（使其下一次反向扫描）
					if x1<=360 and flag==false then
						wLog("jump","change flag")
						flag=true
					--当小紫人在屏幕右边或flag==true时，从下一行重新开始扫描
					else
						wLog("jump","j changed")
						j=j+1
					end
					i=1
					goto continue --此处的goto相当于C中的continue（lua中没有continue）
				end
			end

			c0=getColor(xxx, j) --获取上一个颜色并存到c0
			::continue:: --此处的goto相当于C中的continue（lua中没有continue）
			i=i+1
		end
		j=j+1
	end
	wLog("jump","don't find different color!")
	lua_exit()
	mSleep(1000)

	::found_top_point::
	--用于获取目标跳台的最上边的点的横纵坐标的范围（减少循环次数以提高速度）
--	mini=(x21<mini and x21 or mini)
--	maxi=(x22>maxi and x22 or maxi)
--	minj=(y21<minj and y21 or minj)
--	maxj=(y21>maxj and y21 or maxj)
	local tempx2=(x21+x22)/2 --获取第一个参考点（目标跳台的最上边）的横坐标并保存到tempx2



	local y211,y212,y221,y222
	i=x21
	j=y21+1
	while (true) do
		if not isColor(i,j,c0,97) then
			i=i+1
			j=j+1
			if not isColor(i,j,c0,97) then
				y211=j
				break
			end
		end
		i=i-1
	end
	j=j-1
	while isColor(i,j,c0,97) do
		j=j-1
	end
	y212=j
	x21,y21=i,(y211+y212)/2	--(i,y211)和(i,y212)的中点即为第二个参考点（目标跳台的最左边）


	i=x22
	j=y22+1
	while (true) do
		if not isColor(i,j,c0,97) then
			i=i-1
			j=j+1
			if not isColor(i,j,c0,97) then
				y221=j
				break
			end
		end
		i=i+1
	end
	j=j-1
	while isColor(i,j,c0,97) do
		j=j-1
	end
	y222=j
	x22,y22=i,(y221+y222)/2	--(i,y221)和(i,y222)的中点即为第三个参考点（目标跳台的最右边）
	wLog("jump","(x21,y21): ("..x21..","..y21..")".."    (x22,y22): ("..x22..","..y22..")")

	local temp=y22-y21
	local x2,y2
	--目标跳台左右两边的点的纵坐标之差的绝对值不应超过2
	if temp>2 then
		x2,y2=tempx2,y22
	elseif temp<-2 then
		x2,y2=tempx2,y21
	else 	
		x2,y2=(x21+x22)/2,(y21+y22)/2-2
	end

	return x2,y2
end

--init(0)
os.execute("rm "..userPath().."/log/jump.log")
os.execute("rm /sdcard/Pictures/*")

w,h=getScreenSize()
--nLog(w..","..h)
math.randomseed(tostring(os.time()):reverse():sub(1,6))
initLog("jump", 0)
count=1

--mini=w
--minj=h
--maxi=-1
--maxj=-1

while (true) do
	wLog("jump", count)
	t0=os.time()
	keepScreen(true)
	snapScreenToComputer() --截屏到共享目录
	--获取小紫人的底座坐标
	x1,y1 = findMultiColorInRegionFuzzy(0x37355d, "0|-74|0x34353d,-17|-63|0x363b4b,17|-63|0x554e7a,21|1|0x3a3651,-21|1|0x2d2c4d,0|12|0x363c66", 90, 0, 0, 719, 1279,{orient=8})
	if x1==-1 and y1==-1 then --如果未找到小紫人坐标，则认为游戏结束
		wLog("jump","游戏结束")
		lua_exit()
		mSleep(1000)
	end
	--获取目标跳台的中心坐标
	x2,y2=get_center(x1)
	keepScreen(false)
	d=math.sqrt((x1-x2)^2+(y1-y2)^2) --计算距离
	wLog("jump","(x1,y1): ("..x1..","..y1..")\t(x2,y2): ("..x2..","..y2..")\td: "..d)
	a=2
	x,y=w/2+math.random(-100,100),h/2+math.random(-100,100) --随机获取点击的位置

	tap(x,y,a*d)
	mSleep(1500)

	t1=os.time()
	wLog("jump","cost "..(t1-t0).." s")
	count=count+1
	--	mSleep(math.random(1500,2500))
end
wLog("jump", "done")

