---
title: "Go RSA 加密"
date: 2020-12-23T16:36:55+08:00
draft: true
tags:
  - 日常记录
---

生成 RSA 秘钥:

```bash
cd cert
openssl genrsa -out a_rsa_private_key.pem 1024 # 生成私钥
openssl rsa -in a_rsa_private_key.pem -pubout -out a_rsa_public_key.pem # 生成公钥
```

测试:

```go
package util

import (
	"fmt"
	"testing"
)

func TestRSA1(*testing.T) {
	var (
		encrypt       []byte
		decrypt       []byte
		aPublicKey  []byte
		aPrivateKey []byte
		// bPublicKey  []byte
		// bPrivateKey []byte
	)
	plainText := []byte("你好hello world世界")
	fmt.Println("plainText: ", string(plainText))
	// fmt.Println("生成秘钥")
	// privkey, pubkey = GenerateRSAKey(2048)
	aPublicKey = LoadFile("../../cert/a_rsa_public_key.pem")
	aPrivateKey = LoadFile("../../cert/a_rsa_private_key.pem")
	// bPublicKey = LoadFile("../../cert/b_rsa_public_key.pem")
	// bPrivateKey = LoadFile("../../cert/b_rsa_private_key.pem")
	fmt.Println("============= 公钥加密")
	encrypt = RSAPublicKeyEncrypt(plainText, aPublicKey)
	// fmt.Println("加密后的结果 --->", encrypt)
	fmt.Println("============= 私钥解密")
	decrypt = RSAPrivateKeyDecrypt(encrypt, aPrivateKey)
	fmt.Println("解密后的结果 --->", string(decrypt))
	fmt.Println("============= 私钥加密")
	encrypt = RSAPrivateKeyEncrypt(plainText, aPrivateKey)
	// fmt.Println("加密后的结果 --->", encrypt)
	fmt.Println("============= 公钥解密")
	decrypt = RSAPublicKeyDecrypt(encrypt, aPublicKey)
	fmt.Println("解密后的结果 --->", string(decrypt))
}

// FIXME 这个测试用例会报错
func TestRSA2(*testing.T) {
	var (
		aPublicKey  []byte
		aPrivateKey []byte
		bPublicKey  []byte
		bPrivateKey []byte
	)

	plainText := []byte("123")
	fmt.Println("plainText: ", string(plainText))

	aPublicKey = LoadFile("../../cert/a_rsa_public_key.pem")
	aPrivateKey = LoadFile("../../cert/a_rsa_private_key.pem")
	bPublicKey = LoadFile("../../cert/b_rsa_public_key.pem")
	bPrivateKey = LoadFile("../../cert/b_rsa_private_key.pem")

	fmt.Println("====== 先用 a 公钥加密, 再用 b 私钥加密")
	c1 := RSAPublicKeyEncrypt(plainText, aPublicKey)
	fmt.Println("en c1 ok")
	c2 := RSAPrivateKeyEncrypt(c1, bPrivateKey)
	fmt.Println("en c2 ok")
	fmt.Println("====== 先用 b 公钥解密, 再用 a 私钥解密")
	d1 := RSAPublicKeyDecrypt(c2, bPublicKey)
	fmt.Println("de d1 ok")
	d2 := RSAPrivateKeyDecrypt(d1, aPrivateKey)
	fmt.Println("de d2 ok")
	fmt.Println("解密后的结果 --->", string(d2))
}

```

```go
// rsa.go
package util

// RSA 加密解密方面的工具
// 参考:
// - https://www.cnblogs.com/zhichaoma/p/12516715.html
// - https://zhuanlan.zhihu.com/p/86320624

import (
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/subtle"
	"crypto/x509"
	"encoding/pem"
	"math/big"
)

// GenerateRSAKey 生成RSA私钥和公钥
// bits 证书大小
func GenerateRSAKey(bits int) (privkey, pubkey []byte) {
	//GenerateKey函数使用随机数据生成器random生成一对具有指定字位数的RSA密钥
	//Reader是一个全局、共享的密码用强随机数生成器
	privateKey, err := rsa.GenerateKey(rand.Reader, bits)
	if err != nil {
		panic(err)
	}
	//保存私钥
	//通过x509标准将得到的ras私钥序列化为ASN.1 的 DER编码字符串
	X509PrivateKey := x509.MarshalPKCS1PrivateKey(privateKey)
	//构建一个pem.Block结构体对象
	privateBlock := pem.Block{Type: "RSA Private Key", Bytes: X509PrivateKey}
	privkey = pem.EncodeToMemory(&privateBlock)

	//保存公钥
	//获取公钥的数据
	publicKey := privateKey.PublicKey
	//X509对公钥编码
	X509PublicKey, err := x509.MarshalPKIXPublicKey(&publicKey)
	if err != nil {
		panic(err)
	}
	//创建一个pem.Block结构体对象
	publicBlock := pem.Block{Type: "RSA Public Key", Bytes: X509PublicKey}
	pubkey = pem.EncodeToMemory(&publicBlock)
	return
}

func loadPublicKey(key []byte) *rsa.PublicKey {
	//pem解码
	block, _ := pem.Decode(key)
	//x509解码
	publicKeyInterface, err := x509.ParsePKIXPublicKey(block.Bytes)
	if err != nil {
		panic(err)
	}
	return publicKeyInterface.(*rsa.PublicKey)
}

func loadPrivateKey(key []byte) *rsa.PrivateKey {
	//pem解码
	block, _ := pem.Decode(key)
	privateKey, err := x509.ParsePKCS1PrivateKey(block.Bytes)
	if err != nil {
		panic(err)
	}
	return privateKey
}

// RSAPublicKeyEncrypt 用 RSA 公钥加密
// plainText 要加密的数据
// key 秘钥
func RSAPublicKeyEncrypt(plainText, key []byte) []byte {
	publicKey := loadPublicKey(key)
	//对明文进行加密
	cipher, err := rsa.EncryptPKCS1v15(rand.Reader, publicKey, plainText)
	if err != nil {
		panic(err)
	}
	//返回密文
	return cipher
}

// RSAPrivateKeyEncrypt 用 RSA 私钥加密
// plainText 要加密的数据
// key 秘钥
func RSAPrivateKeyEncrypt(plainText, key []byte) []byte {
	privateKey := loadPrivateKey(key)
	cipher, err := rsa.SignPKCS1v15(rand.Reader, privateKey, crypto.Hash(0), plainText)
	if err != nil {
		panic(err)
	}
	return cipher
}

func leftPad(input []byte, size int) (out []byte) {
	n := len(input)
	if n > size {
		n = size
	}
	out = make([]byte, size)
	copy(out[len(out)-n:], input)
	return
}

// RSAPublicKeyDecrypt 用 RSA 公钥解密
// cipherText 需要解密的byte数据
// key 秘钥
func RSAPublicKeyDecrypt(cipher, key []byte) []byte {
	pub := loadPublicKey(key)
	k := (pub.N.BitLen() + 7) / 8
	m := new(big.Int)
	c := new(big.Int).SetBytes(cipher)
	e := big.NewInt(int64(pub.E))
	m.Exp(c, e, pub.N)
	em := leftPad(m.Bytes(), k)
	firstByteIsZero := subtle.ConstantTimeByteEq(em[0], 0)
	secondByteIsTwo := subtle.ConstantTimeByteEq(em[1], 1)
	lookingForIndex := 1
	index := 0
	for i := 2; i < len(em); i++ {
		equals0 := subtle.ConstantTimeByteEq(em[i], 0)
		index = subtle.ConstantTimeSelect(lookingForIndex&equals0, i, index)
		lookingForIndex = subtle.ConstantTimeSelect(equals0, 0, lookingForIndex)
	}
	validPS := subtle.ConstantTimeLessOrEq(2+8, index)
	valid := firstByteIsZero & secondByteIsTwo & (^lookingForIndex & 1) & validPS
	index = subtle.ConstantTimeSelect(valid, index+1, 0)
	return em[index:]
}

// RSAPrivateKeyDecrypt 用 RSA 私钥解密
// cipherText 需要解密的byte数据
// key 秘钥
func RSAPrivateKeyDecrypt(cipher, key []byte) []byte {
	privateKey := loadPrivateKey(key)
	//对密文进行解密
	plainText, _ := rsa.DecryptPKCS1v15(rand.Reader, privateKey, cipher)
	//返回明文
	return plainText
}

```
