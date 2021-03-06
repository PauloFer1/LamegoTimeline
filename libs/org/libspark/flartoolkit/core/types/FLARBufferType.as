/* 
 * PROJECT: FLARToolKit
 * --------------------------------------------------------------------------------
 * This work is based on the FLARToolKit developed by
 *   R.Iizuka (nyatla)
 * http://nyatla.jp/nyatoolkit/
 *
 * The FLARToolKit is ActionScript 3.0 version ARToolkit class library.
 * Copyright (C)2008 Saqoosha
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * For further information please contact.
 *	http://www.libspark.org/wiki/saqoosha/FLARToolKit
 *	<saq(at)saqoosha.net>
 * 
 */
package org.libspark.flartoolkit.core.types
{
	public class FLARBufferType
	{
		private static const T_BYTE1D:int =0x00010000;
		private static const T_INT2D:int  =0x00020000;
		private static const T_SHORT1D:int=0x00030000;
		private static const T_INT1D:int  =0x00040000;
		private static const T_OBJECT:int =0x00100000;
		private static const T_USER:int   =0x00FF0000;
		//  24-31(8)予約
		//  16-27(8)型ID
		//      00:無効/01:byte[]/02:int[][]/03:short[]
		//  08-15(8)ビットフォーマットID
		//      00:24bit/01:32bit/02:16bit
		//  00-07(8)型番号
		//
		/**
		 * RGB24フォーマットで、全ての画素が0
		 */
		public static const NULL_ALLZERO:int = 0x00000001;
		/**
		 * USER - USER+0xFFFFはユーザー定義型。実験用に。
		 */
		public static const USER_DEFINE:int  = T_USER;

		/**
		 * byte[]で、R8G8B8の24ビットで画素が格納されている。
		 */
		public static const BYTE1D_R8G8B8_24:int   = T_BYTE1D|0x0001;
		/**
		 * byte[]で、B8G8R8の24ビットで画素が格納されている。
		 */
		public static const BYTE1D_B8G8R8_24:int   = T_BYTE1D|0x0002;
		/**
		 * byte[]で、R8G8B8X8の32ビットで画素が格納されている。
		 */
		public static const BYTE1D_B8G8R8X8_32:int = T_BYTE1D|0x0101;
		/**
		 * byte[]で、X8R8G8B8の32ビットで画素が格納されている。
		 */
		public static const BYTE1D_X8R8G8B8_32:int = T_BYTE1D|0x0102;
	
		public static const BYTE1D_X8B8G8R8_32:int = T_BYTE1D|0x0103;

        /**　byte[]のYUV420形式
         */
        public static const BYTE1D_YUV420SP:int = T_BYTE1D | 0x0301;

		/**
		 * byte[]で、RGB565の16ビット(little/big endian)で画素が格納されている。
		 */
		public static const BYTE1D_R5G6B5_16LE:int = T_BYTE1D|0x0201;
		public static const BYTE1D_R5G6B5_16BE:int = T_BYTE1D|0x0202;
		/**
		 * short[]で、RGB565の16ビット(little/big endian)で画素が格納されている。
		 */	
		public static const WORD1D_R5G6B5_16LE:int = T_SHORT1D|0x0201;
		public static const WORD1D_R5G6B5_16BE:int = T_SHORT1D|0x0202;

		
		/**
		 * int[][]で特に値範囲を定めない
		 */
		public static const INT2D:int        = T_INT2D|0x0000;
		/**
		 * int[][]で0-255のグレイスケール画像
		 */
		public static const INT2D_GRAY_8:int = T_INT2D|0x0001;
		/**
		 * int[][]で0/1の2値画像
		 * これは、階調値1bitのBUFFERFORMAT_INT2D_GRAY_1と同じです。
		 */
		public static const INT2D_BIN_8:int  = T_INT2D|0x0002;

		/**
		 * int[]で特に値範囲を定めない
		 */
		public static const INT1D:int        = T_INT1D|0x0000;
		/**
		 * int[]で0-255のグレイスケール画像
		 */
		public static const INT1D_GRAY_8:int = T_INT1D|0x0001;
		/**
		 * int[]で0/1の2値画像
		 * これは、階調1bitのINT1D_GRAY_1と同じです。
		 */
		public static const INT1D_BIN_8:int  = T_INT1D|0x0002;
		
		
		/**
		 * int[]で、XRGB32の32ビットで画素が格納されている。
		 */	
		public static const INT1D_X8R8G8B8_32:int=T_INT1D|0x0102;

		/**
		 * H:9bit(0-359),S:8bit(0-255),V(0-255)
		 */
		public static const INT1D_X7H9S8V8_32:int=T_INT1D|0x0103;
		

		/**
		 * プラットフォーム固有オブジェクト
		 */
		public static const OBJECT_Java:int= T_OBJECT|0x0100;
		public static const OBJECT_CS:int  = T_OBJECT|0x0200;
		public static const OBJECT_AS3:int = T_OBJECT|0x0300;
		/**
		 * RGB形式。バッファは、C#のBitmap型オブジェクト
		 */
		public static const OBJECT_CS_Bitmap:int = OBJECT_CS | 0x01;
		public static const OBJECT_CS_Unity:int = OBJECT_CS | 0x11;    
		
		/**
		 * JavaのBufferedImageを格納するラスタ
		 */
		public static const OBJECT_Java_BufferedImage:int= OBJECT_Java|0x01;
        /**
         * AndroidのBitmap型オブジェクト
         */
        public static const OBJECT_And_Bitmap:int= OBJECT_Java|0x11;		
		
		/**
		 * ActionScript3のBitmapDataを格納するラスタ
		 */
		public static const OBJECT_AS3_BitmapData:int= OBJECT_AS3|0x01;
	}

}