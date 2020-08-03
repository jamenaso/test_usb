library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench_usb is
end;

architecture testbench_usb_arq of testbench_usb is

	component main is	
	Port (    
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;

		uart1_ren_o : out STD_LOGIC;              
		uart1_rx_i  : in  STD_LOGIC;
		uart1_tx_o  : out STD_LOGIC;

		uart2_ren_o : out STD_LOGIC;              
		uart2_rx_i  : in  STD_LOGIC;
		uart2_tx_o  : out STD_LOGIC
	); 
	end component;
	
	component uart is
	generic (
		clock_system : integer := 100000000
	);
	Port (  
		clk_sys            : in  STD_LOGIC;
		rst                : in  STD_LOGIC;
		uart_baud_i        : in  STD_LOGIC_VECTOR(3 downto 0);
		uart_parity_i      : in  STD_LOGIC;
		uart_odd_even_i    : in  STD_LOGIC;              
		uart_ld_i          : in  STD_LOGIC;
		uart_tx_busy_o     : out STD_LOGIC;
		uart_din_i         : in  STD_LOGIC_VECTOR(7 downto 0);
		uart_tx_o          : out STD_LOGIC;
		uart_rx_rdy_o      : out STD_LOGIC;
		uart_rx_i          : in  STD_LOGIC;
		uart_dout_o        : out STD_LOGIC_VECTOR(7 downto 0);              
		uart_err_o         : out STD_LOGIC;
		uart_en_o          : out STD_LOGIC
	);
	end component;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';

	signal load : std_logic := '0';
	signal counter: std_logic_vector(7 downto 0) := (7 downto 0 => '0');
	signal busy : std_logic;
	signal tx : std_logic;
	signal rdy : std_logic;
	signal rx : std_logic := '1';
	signal dout: std_logic_vector(7 downto 0);
	signal err : std_logic;
	signal en : std_logic;
	
	signal u1en : std_logic;
	signal u1rx : std_logic;

	signal u2en : std_logic;
	signal u2tx : std_logic;
	signal u2rx : std_logic := '1';

begin

	clk <= not clk after 5 ns;
	--counter <= counter + 1 after 1 ms;

	process
	begin	
		loop		
			wait for 500 us;
			counter <= counter + 1;
			load <= '1';
			wait for 20 ns;
			load <= '0';	
    		end loop;	
	end process;

	UART_PC: uart
	port map(
		clk_sys            => clk,
		rst                => rst,
		uart_baud_i        => "0011",
		uart_parity_i      => '0',
		uart_odd_even_i    => '0',   
		uart_ld_i          => load,
		uart_tx_busy_o     => busy,
		uart_din_i         => counter,
		uart_tx_o          => tx,       
		uart_rx_rdy_o      => rdy,
		uart_rx_i          => rx,
		uart_dout_o        => dout,
		uart_err_o         => err,       
		uart_en_o          => en 
	);
	
	USBMODULE: main		
	port map(
		clk 			=> clk,
		rst				=> rst,

		uart1_ren_o		=> u1en,           
		uart1_rx_i 		=> tx,
		uart1_tx_o 		=> u1rx,

		uart2_ren_o		=> u2en,         
		uart2_rx_i 		=> u2rx,
		uart2_tx_o 		=> u2tx	
	);	
end;
