Nexys-A7-100T-DMA-Audio Demo
====================

Description
-----------

This project demonstrates how to stream data in and out of the Nexys A7-100T's RAM. Vivado is used to build the demo's hardware platform, and Xilinx SDK is used to program the bitstream onto the board and to build and deploy a C application.

To use this demo, the Nexys A7-100T must be connected to a computer over MicroUSB, which must be running a serial terminal. For more information on how to set up and use a serial terminal, such as Tera Term or PuTTY, refer to [this tutorial](https://reference.digilentinc.com/learn/programmable-logic/tutorials/tera-term).

Review statements printed over USB-UART for more information on how to operate this demo.

Files found at [audiocheck.net](https://www.audiocheck.net/testtones_highdefinitionaudio.php) were used to test the demo.

Known Issues
------------

* This demo is a work in progress, and as such only supports WAV files with 96KHz sample rates. Eight and 16 bit audio is supported, but 16-bit data is truncated down to 8 bits, which may result in poor sound quality.
* Hardware Tone Generation functionality is not currently working.
* Wave files are not stored after playback.

Requirements
------------
* **Nexys A7-100T**: To purchase a Nexys A7-100T, see the [Digilent Store](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/).
* **Vivado and Vitis 2020.1 Installations**: To set up Vivado, see the [Installing Vivado and Digilent Board Files Tutorial](https://reference.digilentinc.com/vivado/installing-vivado/start).
* **Serial Terminal Emulator**: 
* **MicroUSB Cable**
* **Audio cables, headphones, and/or speakers**

Demo Setup (v2020.1-1)
----------

1. Download the most recent release ZIP archives from the repo's [releases page](https://github.com/Digilent/Nexys-A7-100T-DMA-Audio/releases). These files are called "Nexys-A7-100T-DMA-Audio-hw-2020.1-1.zip" and "Nexys-A7-100T-DMA-Audio-sw-2020.1-1.zip". The -hw- archive contains an exported XPR project file and associated sources for use with Vivado. The -sw- archive contains exported project files for use with Vitis. Both of these files contain the build products of the associated tool.
2. Extract the downloaded -hw- archive. (Do not extract the -sw- archive)
3. Open Vivado 2020.1.
4. Open the XPR project file, found at \<archive extracted location\>/hw/hw.xpr, included in the extracted hardware release in Vivado 2020.1.
5. No additional steps are required within Vivado. The project can be viewed, modified, and rebuilt, and a new platform can be exported, as desired.
6. Open Vitis 2020.1. Choose an empty folder as the *Workspace* to launch into.
7. With Vitis opened, click the **Import Project** button, under **PROJECT** in the welcome screen.
8. Choose *Vitis project exported zip file* as the Import type, then click **Next**.
9. **Browse** for the downloaded -sw- archive, and **Open** it.
10. Make sure that all boxes are checked in order to import each of the projects present in the archive will be imported, then click **Finish**.
11. Open a serial terminal application (such as TeraTerm) and connect it to the Nexys A7-100T's serial port, using a baud rate of 230400.
12. In the *Assistant* pane at the bottom left of the Vitis window, right click on the project marked `[System]`, and select **Run** -> **Launch Hardware**. When the demo is finished launching, messages will be able to be seen through the serial terminal, and the demo can be used as described in this document's *Description* section, above.

Next Steps
----------
This demo can be used as a basis for other projects by modifying the hardware platform in the Vivado project's block design or by modifying the SDK application project.

Check out the Nexys A7-100T's [Resource Center](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/start) to find more documentation, demos, and tutorials.

For technical support or questions, please post on the [Digilent Forum](forum.digilentinc.com).

Additional Notes
----------------
For more information on how this project is version controlled, refer to the [digilent-vivado-scripts](https://github.com/digilent/digilent-vivado-scripts) and [digilent-vitis-scripts](https://github.com/digilent/digilent-vitis-scripts) repositories.