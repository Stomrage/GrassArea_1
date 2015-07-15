/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mygame.GrassArea;

import com.jme3.export.Savable;
import com.jme3.math.Vector3f;

/**
 * The GrassObject interface. This interface is used to make the grass holding process more generic
 * and also make all of this GrassObject savable
 * @author Stomrage
 * @version 0.1
 */
public interface GrassObject extends Savable{
    /**
     * Give the location of the GrassObject
     * @return grass object location (center)
     */
    public Vector3f getLocation();
    /**
     * This function run through the GrassArea tree to generate the GrassBlade information
     */
    public void generate();
    
    /**
     * Get the size of this GrassObject
     * @return The size of the GrassObject
     */
    public int getSize();
    
}
