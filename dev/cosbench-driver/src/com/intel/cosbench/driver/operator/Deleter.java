/** 
 
Copyright 2013 Intel Corporation, All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 
*/ 

package com.intel.cosbench.driver.operator;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.intel.cosbench.api.storage.StorageException;
import com.intel.cosbench.api.storage.StorageInterruptedException;
import com.intel.cosbench.bench.*;
import com.intel.cosbench.config.Config;
import com.intel.cosbench.driver.util.ObjectPicker;
import com.intel.cosbench.service.AbortedException;

/**
 * This class represents primitive DELETE operation.
 * 
 * @author ywang19, qzheng7
 * 
 */
class Deleter extends AbstractOperator {

    public static final String OP_TYPE = "delete";

    private ObjectPicker objPicker = new ObjectPicker();
    int amount = 0;

    public Deleter() {
        /* empty */
    }

    @Override
    protected void init(String id, int ratio, String division, Config config) {
    	super.init(id, ratio, division, config);
        objPicker.init(division, config);
        //Get the number of deletes
        if(config.get("batch") != null) {
        	amount = pase(config.get("batch"));
        	System.out.println("amount:"+amount);
        }
    }

    @Override
    public String getOpType() {
        return OP_TYPE;
    }

    @Override
    protected void operate(int idx, int all, Session session) {
        String[] path = objPicker.pickObjPath(session.getRandom(), idx, all);
        Sample sample;
        if(amount == 0){
        	sample = doDelete(path[0], path[1], config, session, this);
        }else {
        	sample = doDeleteObjects(path[0], config, session, amount, this);
        }
        session.getListener().onSampleCreated(sample);
        Date now = sample.getTimestamp();
        Result result = new Result(now, getId(), getOpType(), getSampleType(),
				getName(), sample.isSucc());
        session.getListener().onOperationCompleted(result);
    }
    
    public static Sample doDelete(String conName, String objName,
            Config config, Session session, Operator op) {
        if (Thread.interrupted())
            throw new AbortedException();

        long start = System.nanoTime();

        try {
            session.getApi().deleteObject(conName, objName, config);
        } catch (StorageInterruptedException sie) {
            doLogErr(session.getLogger(), sie.getMessage(), sie);
            throw new AbortedException();
        } catch (StorageException se) {
            String msg = "Error deleting object " +  conName + ": " + objName; 
            doLogWarn(session.getLogger(), msg);
        } catch (Exception e) {
        	isUnauthorizedException(e, session);
        	errorStatisticsHandle(e, session, conName + "/" + objName); 

            return new Sample(new Date(), op.getId(), op.getOpType(),
					op.getSampleType(), op.getName(), false);
        }

        long end = System.nanoTime();

        return new Sample(new Date(), op.getId(), op.getOpType(), op.getSampleType(),
				op.getName(), true, (end - start) / 1000000, 0L, 0L);
    }
    
    public static Sample doDeleteObjects(String conName,Config config, Session session, int amount, Operator op) {
        if (Thread.interrupted())
            throw new AbortedException();

        long start = System.nanoTime();

        try {
            session.getApi().deleteObjects(conName, config, amount);
        } catch (StorageInterruptedException sie) {
            doLogErr(session.getLogger(), sie.getMessage(), sie);
            throw new AbortedException();
        } catch (StorageException se) {
            String msg = "Error deleting objects in " +  conName; 
            doLogWarn(session.getLogger(), msg);
        } catch (Exception e) {
        	isUnauthorizedException(e, session);
        	errorStatisticsHandle(e, session, conName); 
            return new Sample(new Date(), op.getId(), op.getOpType(),
					op.getSampleType(), op.getName(), false);
        }

        long end = System.nanoTime();

        return new Sample(new Date(), op.getId(), op.getOpType(), op.getSampleType(),
				op.getName(), true, (end - start) / 1000000, 0L, 0L);
    }
    
    private int pase(String pattern) {
    	 pattern = StringUtils.substringBetween(pattern, "(", ")");
         String[] args = StringUtils.split(pattern, ',');
         int value = Integer.parseInt(args[0]);
         return value;
    }
}
