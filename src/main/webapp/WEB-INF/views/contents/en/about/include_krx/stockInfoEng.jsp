<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.beans.XMLEncoder"%>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="org.xml.sax.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="javax.servlet.http.HttpServletResponse.*"%>
<%@ page import="java.text.*" %> 

<link rel="stylesheet" type="text/css" href="/css/krx_css/stockinfo.css"/>
<script type="text/javascript" src="/js/krx_js/krx_common.js"></script>
<script src="http://asp1.krx.co.kr/inc/js/asp_chart.js"></script>

<%
	String geturl = "http://asp1.krx.co.kr/servlet/krx.asp.XMLSiseEng?code=063170";
	String JongCd = geturl.substring(51, 57);
	String gettime="";
	String janggubun = "";
	String DungRakrate_str = "";
	
	int timeconclude_length = 0;
	int dailystock_length = 0;
	int Askprice_length= 0;
	int Hoga_length= 0;
	
	int CurJuka = 0;
	int Debi = 0;
	float StandardPrice = 0;
	float DungRakrate = 0;
	
	String up = "▲";
	String down = "▼";
	String bohab = "─";
	String line="";
	String xml = "";
	
	String Stockinfo[]= new String [17];
	String Timeconclude[][] = new String [10][7];
	String Dailystock[][] = new String [10][9];
	String Askprice[][] = new String [5][4];
	String Hoga[]= new String [22];
	

	try{
		URL url = new URL(geturl);
		URLConnection conn = url.openConnection();
		HttpURLConnection httpConnection = (HttpURLConnection) conn;
		InputStream is = null;
		InputStreamReader isr = null;
		
		is =  new URL(geturl).openStream();
		isr = new InputStreamReader(is, "euc-kr");		
		
		BufferedReader rd = new BufferedReader(isr,400);
		
		StringBuffer strbuf = new StringBuffer();
		
		//xml line1 공백제거
		while ((line = rd.readLine()) != null){			
		  	strbuf.append(line);
		}
		
		//System.out.println("주가정보");
		//System.out.println(strbuf.toString()); //xml파싱확인
		
		DocumentBuilderFactory docFact = DocumentBuilderFactory.newInstance();
		docFact.setNamespaceAware(true);
		DocumentBuilder docBuild = docFact.newDocumentBuilder();

		Document doc = docBuild.parse(new InputSource(new StringReader(strbuf.toString().replace("&","&amp;"))));

		/*주가정보*/
		
		NodeList stockInfo = doc.getElementsByTagName("stockInfo");
		
		NamedNodeMap stockinfo = stockInfo.item(0).getAttributes();
		gettime = stockinfo.getNamedItem("myNowTime").getNodeValue();
		janggubun = stockinfo.getNamedItem("myJangGubun").getNodeValue();
		
		NodeList TBL_StockInfo = doc.getElementsByTagName("TBL_StockInfo");
		NamedNodeMap StockInfo = TBL_StockInfo.item(0).getAttributes();
		
		Stockinfo[0] = StockInfo.getNamedItem("JongName").getNodeValue();		//종목명 
		Stockinfo[1] = StockInfo.getNamedItem("CurJuka").getNodeValue();		//현재가 
		Stockinfo[2] = StockInfo.getNamedItem("DungRak").getNodeValue();		//전일대비코드
		Stockinfo[3] = StockInfo.getNamedItem("Debi").getNodeValue();			//전일대비
		Stockinfo[4] = StockInfo.getNamedItem("PrevJuka").getNodeValue();		//전일종가 
		Stockinfo[5] = StockInfo.getNamedItem("Volume").getNodeValue();			//거래량
		Stockinfo[6] = StockInfo.getNamedItem("Money").getNodeValue();			//거래대금  
		Stockinfo[7] = StockInfo.getNamedItem("StartJuka").getNodeValue();		//시가 
		Stockinfo[8] = StockInfo.getNamedItem("HighJuka").getNodeValue();		//고가
		Stockinfo[9] = StockInfo.getNamedItem("LowJuka").getNodeValue();		//저가 		
		Stockinfo[10] = StockInfo.getNamedItem("High52").getNodeValue();		//52주 최고 
		Stockinfo[11] = StockInfo.getNamedItem("Low52").getNodeValue();			//52주 최저  
		Stockinfo[12] = StockInfo.getNamedItem("UpJuka").getNodeValue();		//상한가 
		Stockinfo[13] = StockInfo.getNamedItem("DownJuka").getNodeValue();		//하한가 
		Stockinfo[14] = StockInfo.getNamedItem("Per").getNodeValue();			//PER            
		Stockinfo[15] = StockInfo.getNamedItem("Amount").getNodeValue();		//상장주식수    
		Stockinfo[16] = StockInfo.getNamedItem("FaceJuka").getNodeValue();		//액면가
		
		// 등락율 계산
		CurJuka = Integer.parseInt(Stockinfo[1].replaceAll(",", ""));
		Debi = Integer.parseInt(Stockinfo[3].replaceAll(",", ""));
		
		/*등락구분코드*/
		// 1 - 상한, 2 - 상승, 3 - 보합, 4 - 하한, 5 - 하락
		
		if(Stockinfo[2].equals("1")||Stockinfo[2].equals("2")||Stockinfo[2].equals("3")){
			StandardPrice = CurJuka - Debi;
		} else if(Stockinfo[2].equals("4")||Stockinfo[2].equals("5")){
			StandardPrice = CurJuka + Debi;
		}
		
		// 등락률 = (당일종가 - 기준가) / 기준가 * 100
		// 기준가 = 당일종가(현재가) - 전일대비
		DungRakrate = ((CurJuka - StandardPrice) / StandardPrice) * 100;
		DungRakrate_str = String.format("%.2f", DungRakrate);
		
		/*일자별시세*/
		
		NodeList TBL_Dailystock = doc.getElementsByTagName("DailyStock");
		
 		dailystock_length = TBL_Dailystock.getLength();
		
		for(int j=0;j<dailystock_length;j++){
			
			NamedNodeMap DailyStock = TBL_Dailystock.item(j).getAttributes();
			
			Dailystock[j][0] = DailyStock.getNamedItem("day_Date").getNodeValue();		//일자
			Dailystock[j][1] = DailyStock.getNamedItem("day_EndPrice").getNodeValue();	//종가
			Dailystock[j][2] = DailyStock.getNamedItem("day_getDebi").getNodeValue();	//전일대비
			Dailystock[j][3] = DailyStock.getNamedItem("day_Start").getNodeValue();		//시가
			Dailystock[j][4] = DailyStock.getNamedItem("day_High").getNodeValue();		//고가
			Dailystock[j][5] = DailyStock.getNamedItem("day_Low").getNodeValue();		//저가
			Dailystock[j][6] = DailyStock.getNamedItem("day_Volume").getNodeValue();	//거래량
			Dailystock[j][7] = DailyStock.getNamedItem("day_getAmount").getNodeValue();	//거래대금
			Dailystock[j][8] = DailyStock.getNamedItem("day_Dungrak").getNodeValue();	//전일대비코드
			
		}
		
		/*시간대별 체결가*/
		
		NodeList TBL_TimeConclude = doc.getElementsByTagName("TBL_TimeConclude");
		
		timeconclude_length = TBL_TimeConclude.getLength()-1;
		for(int i=0;i<timeconclude_length;i++){
			
			NamedNodeMap TimeConclude = TBL_TimeConclude.item(i+1).getAttributes();
			
			Timeconclude[i][0] = TimeConclude.getNamedItem("time").getNodeValue();		//시간
			Timeconclude[i][1] = TimeConclude.getNamedItem("negoprice").getNodeValue();	//체결가
			Timeconclude[i][2] = TimeConclude.getNamedItem("Debi").getNodeValue();		//전일대비
			Timeconclude[i][3] = TimeConclude.getNamedItem("sellprice").getNodeValue();	//매도호가
			Timeconclude[i][4] = TimeConclude.getNamedItem("buyprice").getNodeValue();	//매수호가
			Timeconclude[i][5] = TimeConclude.getNamedItem("amount").getNodeValue();	//체결량
			Timeconclude[i][6] = TimeConclude.getNamedItem("Dungrak").getNodeValue();	//전일대비코드
		}
		
		/*증권사별거래*/
		
		NodeList TBL_AskPrice = doc.getElementsByTagName("AskPrice");
		
		Askprice_length = TBL_AskPrice.getLength();
		for(int i=0;i<Askprice_length;i++){
			
			NamedNodeMap AskPrice = TBL_AskPrice.item(i).getAttributes();
			
			Askprice[i][0] = AskPrice.getNamedItem("member_memdoMem").getNodeValue();	//매도증권사
			Askprice[i][1] = AskPrice.getNamedItem("member_memdoVol").getNodeValue();	//매도거래량
			Askprice[i][2] = AskPrice.getNamedItem("member_memsoMem").getNodeValue();	//매수증권사
			Askprice[i][3] = AskPrice.getNamedItem("member_mesuoVol").getNodeValue();	//매수거래량
		}
		
		/*호가*/
		
		NodeList TBL_Hoga = doc.getElementsByTagName("TBL_Hoga");
		
		Hoga_length = TBL_Hoga.getLength();


		NamedNodeMap hoga = TBL_Hoga.item(0).getAttributes();
			
		Hoga[0] = hoga.getNamedItem("mesuJan0").getNodeValue();		//매수잔량
		Hoga[1] = hoga.getNamedItem("mesuHoka0").getNodeValue();	//매수호가
		Hoga[2] = hoga.getNamedItem("mesuJan1").getNodeValue();		//매수잔량
		Hoga[3] = hoga.getNamedItem("mesuHoka1").getNodeValue();	//매수호가
		Hoga[4] = hoga.getNamedItem("mesuJan2").getNodeValue();		//매수잔량
		Hoga[5] = hoga.getNamedItem("mesuHoka2").getNodeValue();	//매수호가
		Hoga[6] = hoga.getNamedItem("mesuJan3").getNodeValue();		//매수잔량
		Hoga[7] = hoga.getNamedItem("mesuHoka3").getNodeValue();	//매수호가
		Hoga[8] = hoga.getNamedItem("mesuJan4").getNodeValue();		//매수잔량
		Hoga[9] = hoga.getNamedItem("mesuHoka4").getNodeValue();	//매수호가
		Hoga[10] = hoga.getNamedItem("medoHoka0").getNodeValue();	//매도잔량
		Hoga[11] = hoga.getNamedItem("medoJan0").getNodeValue();	//매도호가
		Hoga[12] = hoga.getNamedItem("medoHoka1").getNodeValue();	//매도잔량
		Hoga[13] = hoga.getNamedItem("medoJan1").getNodeValue();	//매도호가
		Hoga[14] = hoga.getNamedItem("medoHoka2").getNodeValue();	//매도잔량
		Hoga[15] = hoga.getNamedItem("medoJan2").getNodeValue();	//매도호가
		Hoga[16] = hoga.getNamedItem("medoHoka3").getNodeValue();	//매도잔량
		Hoga[17] = hoga.getNamedItem("medoJan3").getNodeValue();	//매도호가
		Hoga[18] = hoga.getNamedItem("medoHoka4").getNodeValue();	//매도잔량
		Hoga[19] = hoga.getNamedItem("medoJan4").getNodeValue();	//매도호가	
		
		DecimalFormat formatter = new DecimalFormat("###,###,###");
				
		Hoga[21] = formatter.format(
				   Integer.parseInt(Hoga[0].replace(",", ""))+
				   Integer.parseInt(Hoga[2].replace(",", ""))+
				   Integer.parseInt(Hoga[4].replace(",", ""))+
				   Integer.parseInt(Hoga[6].replace(",", ""))+
				   Integer.parseInt(Hoga[8].replace(",", "")));
		Hoga[20] = formatter.format(
				   Integer.parseInt(Hoga[11].replace(",", ""))+
				   Integer.parseInt(Hoga[13].replace(",", ""))+
				   Integer.parseInt(Hoga[15].replace(",", ""))+
				   Integer.parseInt(Hoga[17].replace(",", ""))+
				   Integer.parseInt(Hoga[19].replace(",", "")));		
	
	} catch(Exception e){
		
	}


%>

	<div class="header-wrap">
	Real-Time Stock Quotes<span><span class="time_img"></span><%=gettime%> (<%=janggubun%>)</span>
	</div>
	<div class="body-wrap">
		<div id="gpDisp"></div>
		<div class="data-lists">
			<dl>
				<dt><span></span>Stock Information</dt>
				<dd>
					<div class="main_stock_box1">
						<ul>
							<li>
								<div class="main_stock_box1_title">
									<%if(!Stockinfo[0].equals("")){ %>
									<ul>			
										<li class="main_stock_box1_title1">A<%=JongCd%><span><%=Stockinfo[0]%></span></li>
										<li class="main_stock_box1_title2"><span class="CurJuka">Current price</span><%=Stockinfo[1]%></li>
									</ul>
									<ul>
										<li class="main_stock_box1_contn"><span class="title">On the day before</span>
										<span>
										<%if(Stockinfo[2].equals("1")||Stockinfo[2].equals("2")){ %>
										<span class="up">
										<%=up%>
										</span>
										<%} %>
										<%if(Stockinfo[2].equals("3")){ %>
										<span class="bohab">
										<%=bohab%>
										</span>
										<%} %>
										<%if(Stockinfo[2].equals("4")||Stockinfo[2].equals("5")){ %>
										<span class="down">
										<%=down%>
										</span>	
										<%} %>
										<%=Stockinfo[3]%>(<%=DungRakrate_str%>%)
										</span>
										</li>
										<li class="main_stock_box1_contn"><span class="title">Volume</span>
										<span><%=Stockinfo[5]%></span>
										</li>
										<li class="main_stock_box1_contn"><span class="title">Price</span>
										<span><%=Stockinfo[6]%></span>
										</li>
									</ul>
									<%}%>
								</div>
							</li>
						</ul>
					</div>
					<div class="main_stock_box2">
					<table id="stockInfo">
						<tr>
							<th>시가</th>
							<td><%=Stockinfo[7]%></td>
							<th colspan="2">Upper limit</th>
							<td><%=Stockinfo[12]%></td>
						</tr>
						<tr>
							<th>고가</th>
							<td><%=Stockinfo[8]%></td>
							<th colspan="2">Lower limit</th>
							<td><%=Stockinfo[13]%></td>
						</tr>
						<tr>
							<th>저가</th>						
							<td><%=Stockinfo[9]%></td>
							<th colspan="2">Par value</th>
							<td><%=Stockinfo[16]%></td>
						</tr>
						<tr>
							
							<th>PER</th>
							<td><%=Stockinfo[14]%></td>
							<th rowspan="2" style="border-bottom:1px solid #dbdbdb;">52주<br>(Closing price standard)</th>
							<th>Best</th>
							<td><%=Stockinfo[10]%></td>
						</tr>
						<tr>
							<th>Listed shares</th>
							<td><%=Stockinfo[15]%></td>
							<th>Lowest</th>
							<td><%=Stockinfo[11]%></td>
							
						</tr>
					</table>
					</div>
				</dd>
			</dl>
			<ul class="tabs">
		    	<li><a href="#tab1">Call</a></li>
		   		<li><a href="#tab2">Contracts by time</a></li>
		   		<li><a href="#tab3">Membership transaction</a></li>
		   		<li><a href="#tab4">Daily price</a></li>
			</ul>
			<div class="tab_container">
				<div id="tab1" class="tab_content">
					<table id="Hoga">
						<tr>
							<th>Remaining balance</th>
							<th>Call</th>
							<th>Number of shares remaining</th>
						</tr>
						<%if(!Hoga[0].equals("")){%>
							<tr>
								<td><%=Hoga[11]%></td>
								<td><%=Hoga[10]%></td>
								<td></td>
							</tr>
							<tr>
								<td><%=Hoga[13]%></td>
								<td><%=Hoga[12]%></td>
								<td></td>
							</tr>
							<tr>
								<td><%=Hoga[15]%></td>
								<td><%=Hoga[14]%></td>
								<td></td>
							</tr>
							<tr>
								<td><%=Hoga[17]%></td>
								<td><%=Hoga[16]%></td>
								<td></td>
							</tr>
							<tr>
								<td><%=Hoga[19]%></td>
								<td><%=Hoga[18]%></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><%=Hoga[1]%></td>
								<td><%=Hoga[0]%></td>
							</tr>
							<tr>
								<td></td>
								<td><%=Hoga[3]%></td>
								<td><%=Hoga[2]%></td>
							</tr>
							<tr>
								<td></td>
								<td><%=Hoga[5]%></td>
								<td><%=Hoga[4]%></td>
							</tr>
							<tr>
								<td></td>
								<td><%=Hoga[7]%></td>
								<td><%=Hoga[6]%></td>
							</tr>
							<tr>
								<td></td>
								<td><%=Hoga[9]%></td>
								<td><%=Hoga[8]%></td>
							</tr>
							<tr>
								<td><%=Hoga[20]%></td>
								<td>Total balance</td>
								<td><%=Hoga[21]%></td>
							</tr>
						<%} else {%>
							<tr>
								<td colspan="3">No data.</td>
							</tr>
						<%} %>
					</table>
				</div>
	    		<div id="tab2" class="tab_content">
	    			<table id="tradedPrice_time">
						<tr>
							<th>Time</th>
							<th>Contractor</th>
							<th>On the day before</th>
							<th>Sell ​​Price</th>
							<th>Purchase price</th>
							<th>Number of shares remaining</th>
						</tr>
						<%if(timeconclude_length > 0){ %>
							<%for(int i=0;i<timeconclude_length;i++){ %>
							<tr>
								<td><%=Timeconclude[i][0]%></td>
								<td><%=Timeconclude[i][1]%></td>
								<td>
								<%if(Timeconclude[i][6].equals("1")||Timeconclude[i][6].equals("2")){ %>
								<span class="up">
								<%=up%>
								<%} %>
								</span>
								<%if(Timeconclude[i][6].equals("3")){ %>
								<span class="bohab">
								<%=bohab%>
								<%} %>
								</span>
								<%if(Timeconclude[i][6].equals("4")||Timeconclude[i][6].equals("5")){ %>
								<span class="down">
								<%=down%>
								<%} %>
								</span>	
								<%=Timeconclude[i][2]%></td>
								<td><%=Timeconclude[i][3]%></td>
								<td><%=Timeconclude[i][4]%></td>
								<td><%=Timeconclude[i][5]%></td>
							</tr>
							<%} %>
						<%} else {%>
							<tr>
								<td colspan="6">No data.</td>
							</tr>
						<%} %>
					</table>
				</div>
				<div id="tab3" class="tab_content">
					<table id="member_trade">
					<tr>
						<th colspan="2">Sell ​​Top</th>
						<th colspan="2">Number of shares</th>
					</tr>
					<tr>
						<th>Company</th>
						<th>Volume</th>
						<th>Company</th>
						<th>Volume</th>
					</tr>
					<%if(Askprice_length > 0){ %>
						<%for(int i=0;i<Askprice_length;i++){ %>
						<tr>
							<td><%=Askprice[i][0]%></td>
							<td><%=Askprice[i][1]%></td>
							<td><%=Askprice[i][2]%></td>
							<td><%=Askprice[i][3]%></td>
						</tr>
						<%} %>
					<%} else {%>
						<tr>
							<td colspan="4">No data.</td>
						</tr>
					<%} %>
				</table>
				</div>
				<div id="tab4" class="tab_content">
					<table id="tradedPrice_day">
						<tr>
							<th>Date</th>
							<th>Closing price</th>
							<th>On the day before</th>
							<th>Current price</th>
							<th>High price</th>
							<th>Low price</th>
							<th>Volume</th>
							<th>Transaction price</th>
						</tr>
						<%if(dailystock_length > 0){ %>
							<%for(int j=0;j<dailystock_length;j++){ %>
							<tr>
								<td><%=Dailystock[j][0]%></td>
								<td><%=Dailystock[j][1]%></td>
								<td>
								<%if(Dailystock[j][8].equals("1")||Dailystock[j][8].equals("2")){ %>
								<span class="up">
								<%=up%>
								<%} %>
								</span>
								<%if(Dailystock[j][8].equals("3")){ %>
								<span class="bohab">
								<%=bohab%>
								<%} %>
								</span>
								<%if(Dailystock[j][8].equals("4")||Dailystock[j][8].equals("5")){ %>
								<span class="down">
								<%=down%>
								<%} %>
								</span>	
								<%=Dailystock[j][2]%></td>
								<td><%=Dailystock[j][3]%></td>
								<td><%=Dailystock[j][4]%></td>
								<td><%=Dailystock[j][5]%></td>
								<td><%=Dailystock[j][6]%></td>
								<td><%=Dailystock[j][7]%></td>
							</tr>
							<%} %>
						<%} else {%>
							<tr>
								<td colspan="8">No data.</td>
							</tr>
						<%} %>
					</table>
				</div>
			</div>				
		</div>
	</div>