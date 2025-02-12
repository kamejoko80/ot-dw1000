/**
 * Copyright 2017 Decawave Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*! ----------------------------------------------------------------------------
 *  @file    dw1000_param_types.h
 *  @brief   DecaWave general type definitions for configuration structures
 *
 */
#ifndef _DECA_PARAM_TYPES_H_
#define _DECA_PARAM_TYPES_H_

#ifdef __cplusplus
extern "C" {
#endif
#include "dw1000_types.h"

#define NUM_BR 3
#define NUM_PRF 2
#define NUM_PACS 4
#define NUM_BW 2 //2 bandwidths are supported
#define NUM_SFD 2   //supported number of SFDs - standard = 0, non-standard = 1
#define NUM_CH 6 //supported channels are 1, 2, 3, 4, 5, 7
#define NUM_CH_SUPPORTED 8 //supported channels are '0', 1, 2, 3, 4, 5, '6', 7
#define PCODES 25 //supported preamble codes


typedef struct {
        uint32 lo32;
        uint16 target[NUM_PRF];
} agc_cfg_struct ;

extern const agc_cfg_struct agc_config ;

//SFD threshold settings for 110k, 850k, 6.8Mb standard and non-standard
extern const uint16 sftsh[NUM_BR][NUM_SFD];

extern const uint16 dtune1[NUM_PRF];

#define XMLPARAMS_VERSION   (1.17f)

extern const uint8 pll2_config[NUM_CH][5];
extern const uint8 pll2calcfg;
extern const uint8 rx_config[NUM_BW];
extern const uint32 tx_config[NUM_CH];
extern const uint8 dwnsSFDlen[NUM_BR];              //length of SFD for each of the bitrates
extern const uint32 digital_bb_config[NUM_PRF][NUM_PACS];
extern const uint8 chan_idx[NUM_CH_SUPPORTED];

#define PEAK_MULTPLIER (0x60)   //3 -> (0x3 * 32) & 0x00E0
#define N_STD_FACTOR (13)
#define LDE_PARAM1      (PEAK_MULTPLIER | N_STD_FACTOR)

#define LDE_PARAM3_16 (0x1607)
#define LDE_PARAM3_64 (0x0607)

extern const uint16 lde_replicaCoeff[PCODES];

#ifdef __cplusplus
}
#endif

#endif


