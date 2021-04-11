package popups
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import library.basic.Popup;
   import library.events.MainEvent;
   import library.interfaces.Idestroyable;
   import library.sounds.SoundManager;
   
   public class PopupSaveConfirm extends Popup implements Idestroyable
   {
       
      
      private var btnOK:SimpleButton;
      
      public function PopupSaveConfirm(_mcRef:MovieClip)
      {
         super(_mcRef);
         addState(sSTATE_APPEAR,state_appear,loadState);
         addState(sSTATE_IDLE,null,loadState);
         addState(sSTATE_DISAPPEAR,state_disappear,loadState);
         Main.instance.addEventListener(MainEvent.EVENT_UPDATE,update,false,0,true);
         Main.instance.addEventListener(MainEvent.EVENT_DESTROY,destroy,false,0,true);
         setState(sSTATE_APPEAR);
      }
      
      public function onRollOver(_e:MouseEvent) : void
      {
         var _loc2_:* = _e.target;
         switch(0)
         {
         }
         trace("Over: " + _e.target.name);
         SoundManager.playSoundInCat(Data.sCATEGORY_SOUND_LINKAGE,"sndRollOver",1,1,true);
      }
      
      public function onClick(_e:MouseEvent) : void
      {
         switch(_e.target)
         {
            case btnOK:
               close();
         }
         SoundManager.playSoundInCat(Data.sCATEGORY_SOUND_LINKAGE,"sndClick",1,1,true);
      }
      
      public function destroy(_e:Event = null) : void
      {
         setButton(btnOK,onClick,onRollOver,true);
         if(mcRef != null)
         {
            mcRef.parent.removeChild(mcRef);
         }
         Main.instance.removeEventListener(MainEvent.EVENT_UPDATE,update,false);
         Main.instance.removeEventListener(MainEvent.EVENT_DESTROY,destroy,false);
         btnOK = null;
         mcRef = null;
      }
      
      private function loadState() : void
      {
         if(mcRef.mcBlocker != null)
         {
            mcRef.mcBlocker.useHandCursor = false;
         }
         switch(state)
         {
            case sSTATE_APPEAR:
               SoundManager.playSoundInCat(Data.sCATEGORY_SOUND_LINKAGE,"sndPopupIn.wav",1,1,true);
               break;
            case sSTATE_IDLE:
               btnOK = mcState.mcPopup.btnOk;
               setButton(btnOK,onClick,onRollOver);
               break;
            case sSTATE_DISAPPEAR:
               SoundManager.playSoundInCat(Data.sCATEGORY_SOUND_LINKAGE,"sndPopupOut.wav",1,1,true);
         }
      }
   }
}
