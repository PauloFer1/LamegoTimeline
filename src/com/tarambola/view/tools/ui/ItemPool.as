package com.tarambola.view.tools.ui
{
	public class ItemPool
	{
		/** Minimum size of the pool. */
		private var _minSize:int;
		
		/** Maximum size of the pool. */
		private var _maxSize:int;
		
		/** Current size of the pool (list). */
		public var size:int = 0;
		
		/** Function to be called when the object is to be created. */
		public var create:Function;
		
		/** Function to be called when the object is to be cleaned. */
		public var clean:Function;
		
		/** Checked in objects count. */
		public var length:int = 0;
		
		/** Objects in the pool. */
		private var _list:Vector.<Item>;
		
		/** If this pool has been disposed. */
		private var disposed:Boolean = false;
		
		public function ItemPool(create:Function, clean:Function = null, minSize:int = 1, maxSize:int = 70)
		{
			this._list = new Vector.<Item>;
			
			this.create = create;
			this.clean = clean;
			this.minSize = minSize;
			this.maxSize = maxSize;
			
			// Create minimum number of objects now. Later in run-time, if required, more objects will be created < maximum number.
			for(var i:int = 0; i<this.minSize; i++) 
				this.add();
		}
		/**
		 * Add new objects and check-in to the pool. 
		 * 
		 */
		private function add():void
		{
			this._list[this.length++] = create();
			this.size++;
		}
		
		/**
		 * Sets the minimum size for the Pool.
		 *
		 */
		public function set minSize(num:int):void
		{
			this._minSize = num;
			if(this._minSize > this._maxSize) 
				this._maxSize = this._minSize;
			if(this._maxSize < this._list.length) 
				this._list.splice(this._maxSize, 1);
			
			this.size = this._list.length;
		}
		
		/**
		 * Gets the minimum size for the Pool.
		 *
		 */
		public function get minSize():int
		{
			return this._minSize;
		}
		
		/**
		 * Sets the maximum size for the Pool.
		 *
		 */
		public function set maxSize(num:int):void
		{
			this._maxSize = num;
			if(this._maxSize < this._list.length) 
				this._list.splice(_maxSize, 1);
			this.size = this._list.length;
			if(this._maxSize < this._minSize) 
				this._minSize = this._maxSize;
		}
		
		/**
		 * Returns the maximum size for the Pool.
		 *
		 */
		public function get maxSize():int
		{
			return this._maxSize;
		}
		
		/**
		 * Checks out an Object from the pool.
		 *
		 */
		public function checkOut():Item
		{
			if(this.length == 0) {
				if(this.size < this.maxSize) {
					this.size++;
					return create();
				} else {
					return null;
				}
			}
			
			return this._list[--this.length];
		}
		
		/**
		 * Checks the Object back into the Pool.
		 * @param item The Object you wish to check back into the Object Pool.
		 *
		 */
		public function checkIn(item:Item):void
		{
			if(clean != null) 
				clean(item);
			this._list[this.length++] = item;
		}
		
		/**
		 * Disposes the Pool ready for GC.
		 *
		 */
		public function dispose():void
		{
			if(disposed) return;
			
			disposed = true;
			
			create = null;
			clean = null;
			this._list = null;
		}
	}
}