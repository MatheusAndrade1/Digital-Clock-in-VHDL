library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--op = 00 relogio normal
--op = 01 ajuste alarme
--op = 10 ajuste relogio
entity main is
port (
  clk    : in std_logic;
  plusm: in std_logic;
  plush: in std_logic;
  alarme_sw: in std_logic;
  brilho: in std_logic;
  OP: in STD_LOGIC_VECTOR (1 downto 0);
  parar: in std_logic; 
  top: in std_logic; 
  clear: in STD_LOGIC;
  buzzer: out std_logic;
  led1, led2: out STD_LOGIC:='1';
  leda1,leda2,leda3: out STD_LOGIC;
  seg: out STD_LOGIC_VECTOR (6 downto 0);
  an: out STD_LOGIC_VECTOR (3 downto 0)
  
);
end main;
 
architecture Behavioral of main is
  signal q0,q1,q2,q3,q0a,q1a,q2a,q3a : STD_LOGIC_VECTOR(3 downto 0); --vai para o display
  signal count,count2,count3,count4,count5,count6  : integer :=1;
  signal clkmin, clka, clks, clk2, a ,b, c, spulso, plus1, plus2, plus3, plus4, plus5, plus6, alarme, do, si, buzzer1,buzzer2, leds1, leds2, i1, i2, is1: std_logic :='0';
  signal mua, hua, mda, hda: integer range 0 to 9:=0;
  signal muc, huc, mdc, hdc: integer range 0 to 9:=0;  --vai para o display depois de ser contado
  signal muca, huca, mdca, hdca: integer range 0 to 9:=0;  --vai para o display depois de ser contado
  signal n0a,n1a,n2a,n3a : integer range 0 to 9 :=0;
  signal n0, n1, n2, n3 : integer range 0 to 9 :=0;
  signal segl: STD_LOGIC_VECTOR (6 downto 0);
  signal anl: STD_LOGIC_VECTOR (3 downto 0);
  signal opl: STD_LOGIC_VECTOR (1 downto 0);
  constant n: integer := 50000000;

begin
   
	--n0,n1,n2,n3 vão para o contador, saem dele os sinais que vão para o display
   Cont_inst: entity work.Cont
   port map (
			clk => clkmin,
		  enablem => plus3,
		  enableh => plus4,
		  clear => clear,
		  op => op,
        hdl => n0, --entradas
        hul => n1,
        mdl => n2,
        mul => n3,
        n0 => hdc, --saidas
        n1 => huc,
        n2 => mdc,
        n3 => muc
   );
   
   Cont_ajuste_inst: entity work.Cont
      port map (
             clk => clka,
             enablem => plus5,
             enableh => plus6,
             clear => clear,
             op => op,
           hdl => n0, --entradas
           hul => n1,
           mdl => n2,
           mul => n3,
           n0 => hdca, --saidas
           n1 => huca,
           n2 => mdca,
           n3 => muca
      );
   

	Alarme_inst: entity work.Ajuste_alarme
   port map (
		clk => clka,
		  enablem => plus2,
		  enableh => plus1,
		  clear => clear,
        hdl => hda, --entradas
        hul => hua,
        mdl => mda,
        mul => mua,
        n0 => n0a, --saidas
        n1 => n1a,
        n2 => n2a,
        n3 => n3a
   );
	

	
Def_inst: entity work.Defasador
port map(
	clk=>clk,
	clk1=>a,
	clk2=>b,
	clk3=>c,
	spulso=>spulso
);


	
	FF1_inst: entity work.Flip_Flop
	port map(
		clk => b,
		d => i1,---entrada
		q => is1---saida
	);   

   
   DISP_inst: entity work.DISP
   port map (
        q0 => q0,
        q1 => q1,
        q2 => q2,
        q3 => q3,
        seg => segl,
        an => anl,
		  clk => clk
   );	
	
 
  process(clk)
  begin
    if(clk'event and clk='1') then
		count <= count +1;     		
		count2 <= count2 +1;	 
		count3 <= count3 +1;
		count4 <= count4 +1;
		count5 <= count5 +1; 
		count6 <= count6 +1;
		
		
		if(count = (n/2)) then -- 1 minuto
		  clkmin <= not clkmin;
		  count <=1;
		end if;
			
		if(count2 = n/16) then 
			clka <= not clka;
			count2 <= 1;
		end if;
		
		if(count6 = n/2) then  -- 1 segundo
			clks <= not clks;
			count6 <= 1;
		end if;
		
		if(count3=(n/2)/264) then
			count3<= 1;
			do <= not(do);
		end if;
		
		if(count4=(n/2)/495) then
			count4<= 1;
			si <= not(si);
		end if;
		
		if(count5 = (n/10000)) then 
        clk2 <=not clk2;
        count5 <=1;
      end if;			
	  -----checando a opção selecionada nos switchs
	 if (op = "10") then --ajuste relogio
			  plus5 <= not(plusm);
			  plus6 <= not(plush);
			  plus3<='0';
			  plus4<='0';
			  
			  q0 <= conv_std_logic_vector(hdca,4);
			  q1 <= conv_std_logic_vector(huca,4);
			  q2 <= conv_std_logic_vector(mdca,4);
			  q3 <= conv_std_logic_vector(muca,4);
			  n0 <= conv_integer(unsigned(q0));
			  n1 <= conv_integer(unsigned(q1));
			  n2 <= conv_integer(unsigned(q2));
			  n3 <= conv_integer(unsigned(q3));
  
	 elsif (op="01") then --ajuste alarme
			  plus2 <= not(plusm);
			  plus1 <= not(plush);
			  
			  plus3 <= '1'; 
			  
			  ------salva o valor do display
			  q0 <= conv_std_logic_vector(n0a,4);
			  q1 <= conv_std_logic_vector(n1a,4);
			  q2 <= conv_std_logic_vector(n2a,4);
			  q3 <= conv_std_logic_vector(n3a,4); 
			  hda <= conv_integer(unsigned(q0));
			  hua <= conv_integer(unsigned(q1));
			  mda <= conv_integer(unsigned(q2));
			  mua <= conv_integer(unsigned(q3));
			  
			  ------continua contando em background
			  n0 <= hdc;
			  n1 <= huc;
			  n2 <= mdc;
			  n3 <= muc;
		 
		 else			
			  plus3 <= '1'; 
			  plus4 <= '0';
			  
			  q0 <= conv_std_logic_vector(hdc,4);
			  q1 <= conv_std_logic_vector(huc,4);
			  q2 <= conv_std_logic_vector(mdc,4);
			  q3 <= conv_std_logic_vector(muc,4);
			  n0 <= conv_integer(unsigned(q0));
			  n1 <= conv_integer(unsigned(q1));
			  n2 <= conv_integer(unsigned(q2));
			  n3 <= conv_integer(unsigned(q3));
			  
			  if(alarme_sw='1') then
					if(n0a = hdc and n1a=huc and n2a=mdc and n3a=muc and is1/=i2) then
--                    leds <= '0';
						 alarme <= '1';
					end if;
			  end if;    
			  
		 end if;
		 
			 
			if(alarme_sw='1') then
				leda1<='0';
				leda2<='0';
				leda3<='0';    
		  else
--                leds <= '1';
				alarme <= '0';
				leda1<='1';
				leda2<='1';
				leda3<='1';    
		  end if;    
					 
		if(parar='0' and is1/=i2)then
			 i2<=is1;
			 alarme <= '0';
		end if;
  
  
  
		if(top='0')then
			 buzzer<=buzzer1;
		else
			 buzzer<=buzzer2;
		end if;


		end if;	 ---if do clk
  end process;
 -------------------------------------------------------------------------
  
  
 
 
 process(do)
  begin
  if(alarme='1')then
		if(top='0')then
			if (do='1') then
				buzzer1 <= '0';
			else
				buzzer1 <= '1';
			end if;		
		end if;
	else
		buzzer1 <= '1';
	end if;
  end process;
  
  process(si)
  begin
  if(alarme='1')then
		if(top='1')then
			if (si='1') then
				buzzer2 <= '0';
			else
				buzzer2 <= '1';
			end if;		
		end if;
	else
		buzzer2 <= '1';	
	end if;
  end process;
  
  
  process(clk2)
  begin
	  if(brilho='0')then
			if(clk2='1')then
				seg<=segl;
				an<=anl;
			else
				seg<="1111111";
				an<="1111";
			end if;
		else
			seg<=segl;
			an<=anl;
		end if;
  end process;
  
  process(clka)
  begin
		if(alarme='1')then
			if(clka='1')then
				leds1<='1';
				leds2<='0';			
			else
				leds1<='0';
				leds2<='1';				
			end if;
		else
			leds1<='1';
			leds2<='1';		
		end if;
		led1<=leds1;
		led2<=leds2;	
  end process;
  
  process(clkmin)
  begin
	if(clkmin'event and clkmin='1')then
		if(op="00" or op="11")then
			if(i1=i2)then
				i1<=not(i1);
			end if;
		end if;
	end if;
  end process;
end Behavioral;