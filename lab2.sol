// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract IntegerVariations {
    int8 public int8Var;
    int16 public int16Var;
    int32 public int32Var;
    int64 public int64Var;
    int128 public int128Var;
    int256 public int256Var;

    uint8 public uint8Var;
    uint16 public uint16Var;
    uint32 public uint32Var;
    uint64 public uint64Var;
    uint128 public uint128Var;
    uint256 public uint256Var;

    int256 public minInt8 = type(int8).min;
    int256 public maxInt8 = type(int8).max;
    int256 public minInt16 = type(int16).min;
    int256 public maxInt16 = type(int16).max;
    int256 public minInt32 = type(int32).min;
    int256 public maxInt32 = type(int32).max;
    int256 public minInt64 = type(int64).min;
    int256 public maxInt64 = type(int64).max;
    int256 public minInt128 = type(int128).min;
    int256 public maxInt128 = type(int128).max;
    int256 public minInt256 = type(int256).min;
    int256 public maxInt256 = type(int256).max;


}
