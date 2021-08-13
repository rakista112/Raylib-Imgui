/*******************************************************************************************
*
*   raylib [core] example - Basic window
*
*   Welcome to raylib!
*
*   To test examples, just press F6 and execute raylib_compile_execute script
*   Note that compiled executable is placed in the same folder as .c file
*
*   You can find all basic examples on C:\raylib\raylib\examples folder or
*   raylib official webpage: www.raylib.com
*
*   Enjoy using raylib. :)
*
*   This example has been created using raylib 1.0 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5)
*
********************************************************************************************/
extern "C" {
    #include <raylib.h>
}
#include "imgui.h"

#include "rlImGui.h"


int main(void)
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const int screenWidth = 800;
    const int screenHeight = 450;
    char windowTitle[4096] = "ArkText";


    InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    SetupRLImGui(true);
    Image img = GenImageChecked(64, 64, 16, 16, DARKGRAY, GRAY);
    Texture bg = LoadTextureFromImage(img);
    UnloadImage(img);

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            BeginRLImGui();
       ImGui::SetNextWindowPos(ImVec2(0, 0));                                                  // always at the window origin
        ImGui::SetNextWindowSize(ImVec2(float(GetScreenWidth()), float(GetScreenHeight())));    // always at the window size
        bool show = (ImGui::Begin("Main", NULL, ImGuiWindowFlags_NoScrollbar));                                   // show the "window"

        // Window title text edit
        ImGui::InputTextMultiline("", windowTitle, 4096, ImVec2(640, 480));
 
        if (ImGui::Button("Run Sketch")) {
           // state.reset();
           
        }
        ImGui::End(); // end window

            ClearBackground(RAYWHITE);

            DrawText("Congrats! You created your first window!", 190, 200, 20, ColorAlpha(RED,0.75f));
		EndRLImGui();

        EndDrawing();
        //----------------------------------------------------------------------------------
    }
    	ShutdownRLImGui();


    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}