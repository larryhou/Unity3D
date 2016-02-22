﻿using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

class ExportTool
{
	static void ExportXcodeProject () 
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget (BuildTarget.iOS);

		EditorUserBuildSettings.symlinkLibraries = true;
		EditorUserBuildSettings.development = true;
		EditorUserBuildSettings.allowDebugging = true;

		List<string> scenes = new List<string>();
		for (int i = 0; i < EditorBuildSettings.scenes.Length; i++) 
		{
			Debug.Log ("Add Scene: " + EditorBuildSettings.scenes [i].path);
			if (EditorBuildSettings.scenes [i].enabled)
			{
				scenes.Add (EditorBuildSettings.scenes [i].path);
			}
		}

		BuildPipeline.BuildPlayer (scenes.ToArray (), "iOSProj", BuildTarget.iOS, BuildOptions.None);
	}
}
