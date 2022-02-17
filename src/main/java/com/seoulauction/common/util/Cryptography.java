package com.seoulauction.common.util;

import org.apache.commons.net.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class Cryptography {
	
	public static String encryptAes(String strDataToEncrypt, String key) {
		String strCipherText = "";
		String strDecryptedText = "";
		
		try{
			/**
			 *  Step 1. Generate an AES key using KeyGenerator
			 *  		Initialize the keysize to 128 
			 * 
			 */
			//KeyGenerator keyGen = KeyGenerator.getInstance("AES");
			//keyGen.init(128);
			//SecretKey secretKey = keyGen.generateKey();
			SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");
			
			/**
			 *  Step2. Create a Cipher by specifying the following parameters
			 * 			a. Algorithm name - here it is AES
			 */
			
			Cipher aesCipher = Cipher.getInstance("AES");
			
			/**
			 *  Step 3. Initialize the Cipher for Encryption 
			 */
			
			aesCipher.init(Cipher.ENCRYPT_MODE, keySpec);
			
			/**
			 *  Step 4. Encrypt the Data
			 *  		1. Declare / Initialize the Data. Here the data is of type String
			 *  		2. Convert the Input Text to Bytes
			 *  		3. Encrypt the bytes using doFinal method 
			 */
			byte[] byteDataToEncrypt = strDataToEncrypt.getBytes();
			byte[] byteCipherText = aesCipher.doFinal(byteDataToEncrypt); 
			strCipherText = Base64.encodeBase64String(byteCipherText);
			
		}
		catch (NoSuchAlgorithmException noSuchAlgo){
			System.out.println(" No Such Algorithm exists " + noSuchAlgo);
		}
		catch (NoSuchPaddingException noSuchPad){
			System.out.println(" No Such Padding exists " + noSuchPad);
		}
		catch (InvalidKeyException invalidKey){
			System.out.println(" Invalid Key " + invalidKey);
		}
		catch (BadPaddingException badPadding){
			System.out.println(" Bad Padding " + badPadding);
		}
		catch (IllegalBlockSizeException illegalBlockSize){
			System.out.println(" Illegal Block Size " + illegalBlockSize);
		}
		return strCipherText.trim();
	}
	
	public static String decryptAes(String strCipherText, String key){
		String strDecryptedText = "";
		try{
			/**
			 *  Step 1. Generate an AES key using KeyGenerator
			 *  		Initialize the keysize to 128 
			 * 
			 */
			//KeyGenerator keyGen = KeyGenerator.getInstance("AES");
			//keyGen.init(128);
			//SecretKey secretKey = keyGen.generateKey();
			SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");
			/**
			 *  Step2. Create a Cipher by specifying the following parameters
			 * 			a. Algorithm name - here it is AES
			 */
			
			Cipher aesCipher = Cipher.getInstance("AES");
			//aesCipher.init(Cipher.ENCRYPT_MODE, keySpec);			
			/**
			 *  Step 5. Decrypt the Data
			 *  		1. Initialize the Cipher for Decryption 
			 *  		2. Decrypt the cipher bytes using doFinal method 
			 */
			
			aesCipher.init(Cipher.DECRYPT_MODE, keySpec);//, aesCipher.getParameters());
			//byte[] byteCipherText = aesCipher.doFinal(Base64.decodeBase64(strCipherText));

			byte[] byteDecryptedText = aesCipher.doFinal(Base64.decodeBase64(strCipherText));
			strDecryptedText = new String(byteDecryptedText);
		}
		catch (NoSuchAlgorithmException noSuchAlgo){
			System.out.println(" No Such Algorithm exists " + noSuchAlgo);
		}
		catch (NoSuchPaddingException noSuchPad){
			System.out.println(" No Such Padding exists " + noSuchPad);
		}
		catch (InvalidKeyException invalidKey){
			System.out.println(" Invalid Key " + invalidKey);
		}
		catch (BadPaddingException badPadding){
			System.out.println(" Bad Padding " + badPadding);
		}
		catch (IllegalBlockSizeException illegalBlockSize){
			System.out.println(" Illegal Block Size " + illegalBlockSize);
		}
		
		return strDecryptedText.trim();
	}
}
