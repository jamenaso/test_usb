----------------------------------------------------------------------------------
-- Company: GEO Tecnologies SAS
-- Engineer: Jairo Mena Muñoz
-- 
-- Create Date: 11.05.2020 09:58:48
-- Design Name: USB Prueba Unitaria - Programa Principal
-- Module Name: main - Behavioral
-- Project Name: Prueba Unitaria USB
-- Target Devices: GEO-HCAL-1.0.0
-- Tool Versions: 1.0.0 
-- Description: Programa principal que tiene dos instancias del Módulo UART el cual están conectados en puente
--              Conexionado el UART1-Tx => UART2-Rx y  UART2-Tx => UART1-Rx
--              La prueba se hace con CuteCom a 115200 Baudios.  
-- Dependencies: Departamento de Investigación y Desarrollo - GEO Tecnologies SAS
-- 
-- Revision: 1.0 
-- Revision 0.01 - File Created
-- Additional Comments:
-- copyright, © - Jairo Mena - jamenaso@gmail.com
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
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
end main;

architecture Behavioral of main is

    component uart is
    Port 
      (  
        clk_sys 		   : in  std_logic;
        rst                : in  std_logic;
        uart_baud_i        : in  std_logic_vector(3 downto 0);
        uart_parity_i      : in  std_logic;
        uart_odd_even_i    : in  std_logic;              
        uart_ld_i          : in  std_logic;
        uart_tx_busy_o     : out std_logic;
        uart_din_i         : in  std_logic_vector(7 downto 0);
        uart_tx_o          : out std_logic;
        uart_rx_rdy_o      : out std_logic;
        uart_rx_i          : in  std_logic;
        uart_dout_o        : out std_logic_vector(7 downto 0);              
        uart_err_o         : out std_logic;
        uart_en_o          : out std_logic
      );      
    end component; 
    
    signal u1tou2_sig  : std_logic_vector(7 downto 0) := (others => '0');
    signal u2tou1_sig  : std_logic_vector(7 downto 0) := (others => '0');
    
    signal u1load_sig  : std_logic := '0';    
    signal u2load_sig  : std_logic := '0';    
    
    signal u1rdy_sig  : std_logic := '0';    
    signal u2rdy_sig  : std_logic := '0';  
    
    signal u1busy_sig  : std_logic := '0';    
    signal u2busy_sig  : std_logic := '0';         
       
    signal u1err_sig   : std_logic := '0';
    signal u2err_sig   : std_logic := '0';
        
begin

    Inst_UART1 : uart PORT MAP 
    ( 
        clk_sys 		   => clk,
        rst                => rst,
        uart_baud_i        => "0011",
        uart_parity_i      => '0',
        uart_odd_even_i    => '0',  
        uart_ld_i          => u1load_sig,
        uart_tx_busy_o     => u1busy_sig,
        uart_din_i         => u2tou1_sig,
        uart_tx_o          => uart1_tx_o,       
        uart_rx_rdy_o      => u1rdy_sig,
        uart_rx_i          => uart1_rx_i,
        uart_dout_o        => u1tou2_sig,
        uart_err_o         => u1err_sig,       
        uart_en_o          => uart1_ren_o 
    );
    
    Inst_UART2 : uart PORT MAP 
    ( 
        clk_sys            => clk,
        rst                => rst,
        uart_baud_i        => "0011",
        uart_parity_i      => '0',
        uart_odd_even_i    => '0',   
        uart_ld_i          => u2load_sig,
        uart_tx_busy_o     => u2busy_sig,
        uart_din_i         => u1tou2_sig,
        uart_tx_o          => uart2_tx_o,       
        uart_rx_rdy_o      => u2rdy_sig,
        uart_rx_i          => uart2_rx_i,
        uart_dout_o        => u2tou1_sig,
        uart_err_o         => u2err_sig,       
        uart_en_o          => uart2_ren_o 
    );

    process (rst, clk)
    begin
        if (rst = '0') then
            u1load_sig <= '0';
            u2load_sig <= '0';
        elsif (clk'event and clk = '1') then 
            if (u1rdy_sig = '1') then
                if (u2busy_sig = '1') then
                    u2load_sig <= '1';                
                end if;
            else
                u2load_sig <= '0';        
            end if;
            if (u2rdy_sig = '1') then
                if (u1busy_sig = '1') then
                    u1load_sig <= '1';                
                end if;
            else
                u1load_sig <= '0';        
            end if;
        end if;
    end process;
    
end Behavioral;
